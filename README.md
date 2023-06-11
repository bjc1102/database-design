# Contributors
| Name    | Profile                          |
|---------|----------------------------------------|
| 장인석 | [flalini](https://github.com/flalini) |
| 최병주 | [bjc1102](https://github.com/bjc1102) |

# database-design

![데이터베이스 모델링](https://github.com/bjc1102/database-design/assets/71929440/0827ce38-5245-4281-8595-5b615c5c526e)

# Transaction

## 1. 편의점 점주의 상품 발주 시나리오
### I.	발주 상품 추가시 원가와 매가를 자동으로 계산
![그림12](https://github.com/bjc1102/database-design/assets/71929440/a6f949d5-a12b-4349-898c-9f64189ffbfe)


### II.	이후 발주 후 외부 업체에 의해 발주가 상태 변화(trigger를 통한 상태 변경)
![그림11](https://github.com/bjc1102/database-design/assets/71929440/5ddc7b39-f4e0-4103-9417-38b56e519d01)

### III.	상품이 조회되지 않거나 출고하려는 상품이 발주상품보다 많으면 거절하는 사용자 정의 함수
![그림10](https://github.com/bjc1102/database-design/assets/71929440/4ab42f8e-9fcb-4010-94a6-cac66ca787e2)


##2. 편의점 점주의 직원 근태 관리 시나리오
### I.	직원 별 총 근무 시간을 확인할 수 있는 쿼리
![그림9](https://github.com/bjc1102/database-design/assets/71929440/fb9fabfd-cd1f-4b61-854b-c3b057b44212)


## 3. 현재 편의점에서 진행중인 이벤트를 확인하는 시나리오(결제시 이벤트 적용과 분리)
### I.	현재 진행중인 이벤트 정보를 조회할 수 있는 뷰
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `현재적용이벤트뷰` AS 
SELECT
    `이벤트`.`이벤트코드` AS `이벤트코드`,
    `이벤트`.`이벤트방식` AS `이벤트방식`,
    `이벤트`.`할인가격` AS `할인가격`,
    `이벤트`.`이벤트시작날짜` AS `이벤트시작날짜`,
    `이벤트`.`이벤트종료날짜` AS `이벤트종료날짜` 
FROM
    (`이벤트` LEFT JOIN `시간조건` ON (`이벤트`.`이벤트코드` = `시간조건`.`이벤트코드`))
WHERE
    (`이벤트`.`이벤트시작날짜` <= CURDATE())
    AND (`이벤트`.`이벤트종료날짜` >= CURDATE())
    AND (
        (
            (`시간조건`.`시작시간` IS NULL) 
            AND (`시간조건`.`종료시간` IS NULL)
        ) 
        OR (
            (CURTIME() >= `시간조건`.`시작시간`) 
            AND (CURTIME() <= `시간조건`.`종료시간`)
        )
    );
```


### II.	이벤트 진행중인 상품 정보와 방식을 조회 
![그림8](https://github.com/bjc1102/database-design/assets/71929440/b8812dc4-b91c-4fae-830b-74c9bc9f4989)


## 4. 결제 및 판매를 위한 상품 스캔 시나리오

### I.	판매를 위한 상품 스캔(Insert)시 판매가(매가)를 가져오기 위한 함수
![그림7](https://github.com/bjc1102/database-design/assets/71929440/76734a17-d9d9-4013-b982-316a4adf0716)


### II.	판매를 위한 상품 스캔(Insert)시 적용 이벤트를 자동으로 반영하는 트리거(추가, 수정, 삭제)
+ 스캔 상품 추가시(이벤트 적용이 아예 되어있지 않을 시 새로운 이벤트를 추가한다)
  + 1+1, 2+1 항목과 증정품을 구분한다
```
CREATE DEFINER=`root`@`localhost` TRIGGER `판매상품_AFTER_INSERT` AFTER INSERT ON `판매상품` FOR EACH ROW BEGIN

    SET @eid := (
    SELECT 이벤트코드
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = NEW.상품코드
    );
    SET @et := (
    SELECT 이벤트방식
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = NEW.상품코드
    );
    SET @num := (
    SELECT sum(판매수)
    FROM 현재이벤트상품, 판매상품
    WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드 and 현재이벤트상품.이벤트코드 = @eid and 판매상품.판매번호 = NEW.판매번호 and 현재이벤트상품.할인상품 = 1 and 판매상품.취소상품 = 0
    );
	SET @subnum := (
    SELECT sum(판매수)
    FROM 현재이벤트상품, 판매상품
    WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드 and 현재이벤트상품.이벤트코드 = @eid and 판매상품.판매번호 = NEW.판매번호 and 현재이벤트상품.할인상품 = 0 and 판매상품.취소상품 = 0
    );
    SET foreign_key_checks = 0;
    IF @et = '1+1' AND @num > 2 THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수) VALUES (NEW.판매번호, @eid, (@num DIV 2))
        ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 2);
	ELSEIF @et = '2+1' AND @num > 3 THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (NEW.판매번호, @eid, (@num DIV 3))
		ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 3);
	ELSEIF @et = '3+1' AND @num > 4 THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (NEW.판매번호, @eid, (@num DIV 4))
		ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 4);
	ELSEIF @et = '증정' THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (NEW.판매번호, @eid, (LEAST(@num, @subnum)))
		ON DUPLICATE KEY UPDATE 적용횟수 = (LEAST(@num, @subnum));
	ELSEIF @et LIKE '%할인' THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (NEW.판매번호, @eid, @num)
		ON DUPLICATE KEY UPDATE 적용횟수 = @num;
    END IF;
	SET foreign_key_checks = 1;
END
```

+ 스캔상품 삭제시
```
CREATE DEFINER=`root`@`localhost` TRIGGER `판매상품_AFTER_DELETE` AFTER DELETE ON `판매상품` FOR EACH ROW BEGIN
    SET @eid := (
    SELECT 이벤트코드
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = OLD.상품코드
    );
    SET @et := (
    SELECT 이벤트방식
    FROM 현재이벤트상품
    WHERE 현재이벤트상품.상품코드 = OLD.상품코드
    );
    SET @num := (
    SELECT sum(판매수)
    FROM 현재이벤트상품, 판매상품
    WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드 and 현재이벤트상품.이벤트코드 = @eid and 판매상품.판매번호 = OLD.판매번호 and 현재이벤트상품.할인상품 = 1 and 판매상품.취소상품 = 0
    );
	SET @subnum := (
    SELECT sum(판매수)
    FROM 현재이벤트상품, 판매상품
    WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드 and 현재이벤트상품.이벤트코드 = @eid and 판매상품.판매번호 = OLD.판매번호 and 현재이벤트상품.할인상품 = 0 and 판매상품.취소상품 = 0
    );
    SET foreign_key_checks = 0;
	IF @num IS NULL THEN
        DELETE FROM 적용이벤트
        WHERE 판매번호 = OLD.판매번호 AND 이벤트코드 = @eid;
    ELSEIF @et = '1+1' THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
        VALUES (OLD.판매번호, @eid, (@num DIV 2))
        ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 2);
	ELSEIF @et = '2+1' THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (OLD.판매번호, @eid, (@num DIV 3))
		ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 3);
	ELSEIF @et = '3+1' THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (OLD.판매번호, @eid, (@num DIV 4))
		ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 4);
	ELSEIF @et LIKE '%할인' THEN
		INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
		VALUES (OLD.판매번호, @eid, @num)
		ON DUPLICATE KEY UPDATE 적용횟수 = @num;
    END IF;
    SET foreign_key_checks = 1;
END
```

+ 스캔상품 업데이트 시(이벤트가 이미 적용되어있을 때 이미 적용된 이벤트 항목을 업데이트한다)
```
CREATE DEFINER=`root`@`localhost` TRIGGER `판매상품_AFTER_UPDATE` AFTER UPDATE ON `판매상품`
FOR EACH ROW
BEGIN
    SET @eid := (
        SELECT 이벤트코드
        FROM 현재이벤트상품
        WHERE 현재이벤트상품.상품코드 = NEW.상품코드
    );
    SET @et := (
        SELECT 이벤트방식
        FROM 현재이벤트상품
        WHERE 현재이벤트상품.상품코드 = NEW.상품코드
    );
    SET @num := (
        SELECT SUM(판매수)
        FROM 현재이벤트상품, 판매상품
        WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드
            AND 현재이벤트상품.이벤트코드 = @eid
            AND 판매상품.판매번호 = NEW.판매번호
            AND 현재이벤트상품.할인상품 = 1
            AND 판매상품.취소상품 = 0
    );
    SET @subnum := (
        SELECT SUM(판매수)
        FROM 현재이벤트상품, 판매상품
        WHERE 현재이벤트상품.상품코드 = 판매상품.상품코드
            AND 현재이벤트상품.이벤트코드 = @eid
            AND 판매상품.판매번호 = NEW.판매번호
            AND 현재이벤트상품.할인상품 = 0
            AND 판매상품.취소상품 = 0
    );

    SET foreign_key_checks = 0;

    IF @num IS NULL THEN
        DELETE FROM 적용이벤트
        WHERE 판매번호 = OLD.판매번호 AND 이벤트코드 = @eid;
    ELSEIF @et = '1+1' THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
        VALUES (NEW.판매번호, @eid, (@num DIV 2))
        ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 2);
    ELSEIF @et = '2+1' THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
        VALUES (NEW.판매번호, @eid, (@num DIV 3))
        ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 3);
    ELSEIF @et = '3+1' THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
        VALUES (NEW.판매번호, @eid, (@num DIV 4))
        ON DUPLICATE KEY UPDATE 적용횟수 = (@num DIV 4);
    ELSEIF @et LIKE '%할인' THEN
        INSERT INTO 적용이벤트 (판매번호, 이벤트코드, 적용횟수)
        VALUES (OLD.판매번호, @eid, @num)
        ON DUPLICATE KEY UPDATE 적용횟수 = @num;
    END IF;

    SET foreign_key_checks = 1;
END
```

### III.	판매상품 update | delete할 때마다 적용되는 이벤트가 자동 반영
![그림6](https://github.com/bjc1102/database-design/assets/71929440/8ebe53a9-bf85-405d-886c-7c942d723b51)

### IV.	취소상품을 제외한 판매번호와, 판매(보류는 1, 판매 완료는 0으로 표시) 판매가*판매수
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `판매번호별총매가` AS
SELECT
    `판매내역`.`판매번호` AS `판매번호`,
    `판매내역`.`판매완료` AS `판매완료`,
    SUM((`판매상품`.`판매가` * `판매상품`.`판매수`)) AS `총매가`
FROM
    `판매상품`
    JOIN `판매내역` ON (`판매내역`.`판매번호` = `판매상품`.`판매번호`)
WHERE
    (`판매내역`.`판매완료` = 0)
    AND (`판매상품`.`취소상품` = 0)
GROUP BY
    `판매내역`.`판매번호`;
```

### V.	판매번호별로 결제조건을 제외한 할인가를 조회할 수 있다.(이벤트 등 적용하여 할인가를 계산)
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `판매번호별결제조건제외할인가` AS
SELECT
    `판매내역`.`판매번호` AS `판매번호`,
    `판매내역`.`판매완료` AS `판매완료`,
    SUM((`적용이벤트`.`적용횟수` * `이벤트`.`할인가격`)) AS `총할인가`
FROM
    (((`이벤트`
    JOIN `적용이벤트` ON (`이벤트`.`이벤트코드` = `적용이벤트`.`이벤트코드`))
    JOIN `판매내역` ON (`판매내역`.`판매번호` = `적용이벤트`.`판매번호`))
    LEFT JOIN `결제조건` ON (`이벤트`.`이벤트코드` = `결제조건`.`이벤트코드`))
WHERE
    (`판매내역`.`판매완료` = 0)
    AND (`결제조건`.`이벤트코드` IS NULL)
GROUP BY
    `판매내역`.`판매번호`;
```

### VI.	판매번호별 총매가에 앞서 계산한 총할인가(결제조건 할인 제외)를 뺀 값 = 결제 필요 금액(소비자 계산가/부분결제 포함)
+ 결제 필요금액을 구한다

![그림4](https://github.com/bjc1102/database-design/assets/71929440/68b9bef6-ed95-4ef1-9142-1b4a319bad71)


### VII.	판매번호별 총 결제금액 (판매번호당 결제 금액의 총합)
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW A
AS SELECT `결제`.`판매번호` AS `판매번호`, SUM(`결제`.`결제금액`) AS `총결제금액`
FROM `결제`
GROUP BY `결제`.`판매번호`
```

### VIII.	각 결제 가능 조건을 확인하고 결제 조건을 체크하여 추가 할인을 반영한다. 결제가 가능하면 시나리오에 따라 결제 후 판매 완료로 업데이트한다
```
CREATE DEFINER=`root`@`localhost` FUNCTION `SELL_CHECK`(번호 int) RETURNS int
BEGIN
	IF NOT EXISTS ( SELECT 판매번호 FROM 결제필요금액 WHERE 판매번호 = 번호 ) THEN
        RETURN 2;
    ELSEIF NOT EXISTS ( SELECT 판매번호 FROM 결제WHERE 판매번호 = 번호 ) THEN
        RETURN 3;
	ELSEIF NOT EXISTS (SELECT 판매번호 FROM 판매내역 WHERE 판매번호 = 번호 AND 판매완료 = 0) THEN
        RETURN 4;
    END IF;
    SET @eid := (
    SELECT 적용이벤트.이벤트코드
    FROM 적용이벤트, 결제조건
    WHERE 번호 = 적용이벤트.판매번호 and 적용이벤트.이벤트코드 = 결제조건.이벤트코드
    limit 1
    );
    IF @eid IS NOT NULL THEN
		SET @ad := (
			SELECT SUM(적용이벤트.적용횟수 * 이벤트.할인가격)
			FROM 결제, 적용이벤트, 결제조건, 이벤트
			WHERE	결제.판매번호 = 번호 AND
					적용이벤트.판매번호 = 번호 AND
					결제.판매번호 = 적용이벤트.판매번호 AND
					이벤트.이벤트코드 = 적용이벤트.이벤트코드 AND
                    이벤트.이벤트코드 = 결제조건.이벤트코드 AND
					결제.결제방식 LIKE CONCAT('%', 결제조건.결제방식, '%')
        );
	else
		SET @ad = 0;
    END IF;
    SET @rest = (SELECT (결제필요금액.결제필요금액 - 판매번호별총결제금액.총결제금액 - @ad)
               FROM 결제필요금액, 판매번호별총결제금액
               WHERE 결제필요금액.판매번호 = 번호 AND 판매번호별총결제금액.판매번호 = 번호);
    IF @rest != 0 THEN
		RETURN (SELECT 결제필요금액.결제필요금액
        FROM 결제필요금액, 판매번호별총결제금액
               WHERE 결제필요금액.판매번호 = 번호 AND 판매번호별총결제금액.판매번호 = 번호);
    END IF;

	update 판매내역
	SET 판매완료 = 1
    WHERE 판매번호 = 번호;

RETURN 1;
END
```

### IX. 앞선 뷰로 정상적으로 결제가 이루어졌는지 검사하고 최종적으로 판매완료를 체크해준다
+ 판매내역을 업데이트하는 트리거로 앞선 모든 조건을 확인하고 환불/판매완료에 따라 재고를 업데이트한다
+ 판매내역 테이블의 업데이트 후, 판매완료 값이 이전과 다르게 변경되어 1이 되었을 때와 환불여부 값이 이전과 다르게 변경되어 1이 되었을 때 실행되는 트리거
```
CREATE DEFINER=`root`@`localhost` TRIGGER `판매내역_AFTER_UPDATE` AFTER UPDATE ON `판매내역` FOR EACH ROW
BEGIN
    IF OLD.판매완료 = 0 AND NEW.판매완료 = 1 THEN
        SET foreign_key_checks = 0;
        
        DELETE 적용이벤트
        FROM 결제, 적용이벤트, 결제조건
        WHERE 결제.판매번호 = NEW.판매번호
            AND 적용이벤트.판매번호 = NEW.판매번호
            AND 결제조건.이벤트코드 = 적용이벤트.이벤트코드
            AND 결제.판매번호 = 적용이벤트.판매번호
            AND 결제.결제방식 NOT LIKE CONCAT('%', 결제조건.결제방식, '%');
            
        UPDATE 재고
        JOIN 판매상품 ON 판매상품.상품코드 = 재고.상품코드
        SET 재고.수량 = 재고.수량 - 판매상품.판매수
        WHERE 판매상품.판매번호 = NEW.판매번호;
        
        SET foreign_key_checks = 1;
    END IF;

    IF OLD.환불여부 = 0 AND NEW.환불여부 = 1 THEN
        SET foreign_key_checks = 0;
        
        UPDATE 재고
        JOIN 판매상품 ON 판매상품.상품코드 = 재고.상품코드
        SET 재고.수량 = 재고.수량 + 판매상품.판매수
        WHERE 판매상품.판매번호 = NEW.판매번호;
        
        SET foreign_key_checks = 1;
    END IF;
END
```

### X. 판매완료가 이루어진 경우 판매 번호, 결제방식을 저장하고 재고를 업데이트한다
```
CREATE DEFINER=`root`@`localhost` TRIGGER `판매내역_AFTER_UPDATE` AFTER UPDATE ON `판매` FOR EACH ROW
BEGIN
    IF OLD.판매완료 = 0 AND NEW.판매완료 = 1 THEN
        SET foreign_key_checks = 0;
        
        DELETE 적응이벤트
        FROM 결제, 적응이벤트, 결제조건
        WHERE NEW.판매번호 = 결제.판매번호
            AND 결제.판매번호 = 적응이벤트.판매번호
            AND 결제조건.이벤트코드 = 적응이벤트.이벤트코드
            AND 결제.결제방식 NOT LIKE CONCAT('%', 결제조건.결제방식, '');
        
        UPDATE 재고
        JOIN 판매상품 ON 판매상품.상품코드 = 재고.상품코드
        SET 재고.재고수량 = 재고.재고수량 + 판매상품.판매수
        WHERE 판매상품.판매번호 = NEW.판매번호;
        
        SET foreign_key_checks = 1;
    END IF;
END
```



## 5. 최종적으로 매출내역을 불러올 수가 있다
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `판매번호별총결제금액` AS 
SELECT 
    `결제`.`판매번호` AS `판매번호`,
    SUM(`결제`.`결제금액`) AS `총결제금액`
FROM 
    `결제`
    JOIN `판매내역` ON `판매내역`.`판매번호` = `결제`.`판매번호`
WHERE 
    `판매내역`.`판매완료` = 0
GROUP BY 
    `결제`.`판매번호`;
```
+ 매출 내역 필터 추가
-	특정 달의 매출을 알 수 있는 SQL 쿼리
```
SET @y = 2023;
SET @m = 6;

SELECT 
    CONCAT(@y, '/', LPAD(@m, 2, '0')) AS `년/월`,
    SUM(`결제`.`결제금액`) AS `총결제금액`
FROM 
    `결제`
    JOIN `판매내역` ON `판매내역`.`판매번호` = `결제`.`판매번호`
WHERE 
    YEAR(`판매내역`.`판매시각`) = @y
    AND MONTH(`판매내역`.`판매시각`) = @m
    AND `판매내역`.`판매완료` = 1
    AND `판매내역`.`환불여부` = 0;
```

-	특정 날의 매출을 알 수 있는 SQL 쿼리
```
SET @d = '2023-06-01';

SELECT 
    @d AS `날짜`,
    SUM(`결제`.`결제금액`) AS `총결제금액`
FROM 
    `결제`
    JOIN `판매내역` ON `판매내역`.`판매번호` = `결제`.`판매번호`
WHERE 
    DATE(`판매내역`.`판매시각`) = @d
    AND `판매내역`.`판매완료` = 1
    AND `판매내역`.`환불여부` = 0;
```


## 트랜잭션 외 트리거

- 출고상품에 insert 될때 트리거, 미출량에 (발주량-출고량) 삽입과 재고에 상품이 없으면 삽입을, 상품이 있으면 update함
```
CREATE definer=`root`@`localhost` TRIGGER `출고상품_after_insert` after
  INSERT
  ON `출고상품` FOR EACH row begin
  INSERT INTO 미출상품
              (
                     SELECT 출고상품.출고번호,
                            발주상품.상품코드,
                            NULL ,
                            (발주상품.발주개수-출고상품.출고개수)
                     FROM   발주상품,
                            출고,
                            출고상품
                     WHERE  발주상품.상품코드 = 출고상품.상품코드
                     AND    발주상품.발주번호 = 출고.발주번호
                     AND    (
                                   발주상품.발주개수-출고상품.출고개수)>0
              )
  ON duplicate KEY
  UPDATE 출고번호 = 출고상품.출고번호,
         상품코드 = 발주상품.상품코드,
         미출량 = (발주상품.발주개수-출고상품.출고개수);INSERT INTO 재고
              (
                     select 출고상품.상품코드,
                            출고상품.출고개수
                     FROM   출고상품
              )
  ON duplicate KEY
  UPDATE `상품코드`=new.상품코드,
         `수량`=new.출고개수 ;
  END
```

- 발주출고상품뷰, 발주번호별 출고번호,상품코드, 출고개수를 뽑습니다. 
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `발주출고상품뷰` AS
SELECT 
    `출고`.`발주번호` AS `발주번호`,
    `출고상품`.`출고번호` AS `출고번호`,
    `출고상품`.`상품코드` AS `상품코드`,
    `출고상품`.`출고개수` AS `출고개수`
FROM
    `출고상품`
    JOIN `출고` ON `출고`.`출고번호` = `출고상품`.`출고번호`;
```

- 발주출고상품뷰, 발주번호별 출고번호,상품코드, 출고개수를 뽑습니다. 
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `출고집계표` AS
SELECT 
    `a`.`상품코드` AS `상품코드`,
    `a`.`상품이름` AS `상품이름`,
    `a`.`BOX입수` AS `BOX입수`,
    `a`.`발주개수` AS `발주량`,
    `b`.`출고개수` AS `출고량`,
    CONCAT(FLOOR(`b`.`출고개수` / `a`.`BOX입수`), ' BOX ', (`b`.`출고개수` % `a`.`BOX입수`)) AS `출고량BOX`,
    `c`.`미출량` AS `미출량`,
    `a`.`매가` AS `매가`,
    (`a`.`매가` * `b`.`출고개수`) AS `매가금액`
FROM
    (
        (
            (`발주상품뷰` `a`
            JOIN `출고상품` `b`)
            JOIN `출고` `d`)
            JOIN `미출상품` `c`
    )
WHERE
    (
        (`a`.`발주번호` = `d`.`발주번호`)
        AND (`d`.`출고번호` = `b`.`출고번호`)
        AND (`b`.`출고번호` = `c`.`출고번호`)
        AND (`b`.`상품코드` = `c`.`상품코드`)
    );
```
 

- 상품코드에 따라 상품이름, BOX입수,발주량,출고량,미출량,매가,총매가금액 출력
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `출고집계표` AS
SELECT 
    `a`.`상품코드` AS `상품코드`,
    `a`.`상품이름` AS `상품이름`,
    `a`.`BOX입수` AS `BOX입수`,
    `a`.`발주개수` AS `발주량`,
    `b`.`출고개수` AS `출고량`,
    CONCAT(FLOOR(`b`.`출고개수` / `a`.`BOX입수`), ' BOX ', (`b`.`출고개수` % `a`.`BOX입수`)) AS `출고량BOX`,
    `c`.`미출량` AS `미출량`,
    `a`.`매가` AS `매가`,
    (`a`.`매가` * `b`.`출고개수`) AS `매가금액`
FROM
    `발주상품뷰` `a`
    JOIN `출고상품` `b` ON `a`.`발주번호` = `b`.`발주번호`
    JOIN `출고` `d` ON `d`.`출고번호` = `b`.`출고번호`
    JOIN `미출상품` `c` ON `b`.`출고번호` = `c`.`출고번호` AND `b`.`상품코드` = `c`.`상품코드`;

```



- 발주 번호별로 총 매가 금액을 검색
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `발주번호별합계` AS
SELECT 
    `b`.`발주번호` AS `발주번호`,
    SUM((`b`.`원가` * `b`.`발주개수`)) AS `원가합계`,
    SUM((`b`.`매가` * `b`.`발주개수`)) AS `매가합계`
FROM 
    `발주상품` `b`
GROUP BY 
    `b`.`발주번호`;
```


-발주번호 별 상품의 발주 개수,원가,매가,BOX입수,상품중분류를 출력
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `발주상품뷰` AS 
SELECT 
    `a`.`발주번호` AS `발주번호`,
    `a`.`상품코드` AS `상품코드`,
    `b`.`상품이름` AS `상품이름`,
    `a`.`발주개수` AS `발주개수`,
    `a`.`원가` AS `원가`,
    `a`.`매가` AS `매가`,
    `b`.`BOX입수` AS `BOX입수`,
    `b`.`상품중분류` AS `상품중분류`
FROM 
    `발주상품` `a`
JOIN 
    `상품` `b` ON `a`.`상품코드` = `b`.`상품코드`;

-- 출고가 되었을 때, 해당 발주번호의 출고 상태를 미출고에서 출고로 변경하는 trigger
CREATE DEFINER=`root`@`localhost` TRIGGER `출고_AFTER_INSERT` AFTER INSERT ON `출고` FOR EACH ROW 
BEGIN
    UPDATE 발주 SET 발주상태 = '출고' WHERE 발주.발주번호 = NEW.발주번호;
END;
```

- 출고가 되었을 때, 해당 발주번호의 출고 상태를 미출고에서 출고로 변경하는 trigger
```
CREATE DEFINER=`root`@`localhost` TRIGGER `출고_AFTER_INSERT` AFTER INSERT ON `출고` FOR EACH ROW 
BEGIN
    UPDATE 발주 SET 발주상태 = '출고' WHERE 발주.발주번호 = NEW.발주번호;
END;
```

- 상품의 발주날짜에 따라 전체 발주 정보 출력
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `발주출고상품뷰` AS 
SELECT 
    `출고`.`발주번호` AS `발주번호`,
    `출고상품`.`출고번호` AS `출고번호`,
    `출고상품`.`상품코드` AS `상품코드`,
    `출고상품`.`출고개수` AS `출고개수` 
FROM 
    `출고상품` 
    JOIN `출고` ON `출고`.`출고번호` = `출고상품`.`출고번호`;
```


- 해당 상품의 발주개수와 출고개수를 출고번호 별로 비교하여 출력
```
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `발주출고확인뷰` AS
SELECT 
    `발주출고상품뷰`.`출고번호` AS `출고번호`,
    `발주날짜상품뷰`.`상품코드` AS `상품코드`,
    `발주날짜상품뷰`.`발주개수` AS `발주개수`,
    `발주출고상품뷰`.`출고개수` AS `출고개수`
FROM 
    `발주날짜상품뷰`
    JOIN `발주출고상품뷰` ON `발주날짜상품뷰`.`발주번호` = `발주출고상품뷰`.`발주번호`;

-- 발주상품 insert 시 원가와 매가를 자동으로 가져오기 위한 function
CREATE DEFINER=`root`@`localhost` FUNCTION `ORDER_PRODUCT`(
    발주코드 INT,
    주문코드 BIGINT,
    주문수 INT
) RETURNS INT
BEGIN
    -- Function의 내용은 여기에 추가해야 합니다.
    RETURN NULL;
END;
```


- 발주상품 insert 시 원가와 매가를 자동으로 가져오기 위한 function
```
CREATE DEFINER=`root`@`localhost` FUNCTION `ORDER_PRODUCT`(
    발주코드 INT,
    주문코드 BIGINT,
    주문수 INT
) RETURNS INT
BEGIN
    -- 함수의 내용은 여기에 추가해야 합니다.
    RETURN NULL;
END;
```
 

# 입력데이터 (Database dump) 자료

1. 상품 목록(CSV 데이터 덤프)
상품코드, 상품명, BOX입수, 매가, 원가
```
8809153476197 , 델몬트)클래식바나나2입(봉),18,1700,1190
8801121040416 , 매일)바리스타돌체라떼325ML,10,3200,2240
8801121768167 , 매일)바리스타플라넬드립라떼32,10,3200,2240
8801104940382 , 빙그레)식물성바유190ML,24,1500,1050
8801115134213 , 서울)딸기우유300ML,28,1800,1260
8801115114031 , 서울)우유200ML,50,1100,770
8801069418100 , 짱구)초코비초코우유180ML,24,1300,910
```

2. 직원 목록
```
insert into 직원 values (05,"최병주","점원")
```

3. 이벤트 정보 목록
이벤트코드,이벤트방식,할인가격,이벤트시작날짜,이벤트종료날짜
```
1,1+1,5600,2023-05-01,2023-06-30
2,2+1,1800,2023-05-01,2023-06-30
3,1+1,1600,2023-05-01,2023-06-30
```

4. 이벤트 상품 목록
이벤트코드,상품코드,할인상품
```
1,8801007573861,1
2,8801111534220,1
2,8801115134213,1
3,8801037095845,1
3,8801037095876,1
```

5. 판매내역
판매번호,판매시각,환불여부,판매완료
```
1,"2023-05-28 00:12:34",0,1
2,"2023-05-28 00:24:00",0,0
3,"2023-05-28 03:09:00",0,1
4,"2023-05-28 03:13:00",0,1
5,"2023-05-28 03:13:00",0,1
```

6. 판매한 상품
판매번호,상품코드,취소상품,판매수,판매가
```
1,8801007573861,0,5,5600
3,8801019307089,0,2,1000
3,8801115114031,0,1,1100
4,8801068409116,0,1,3900
4,8801073312661,0,2,900
5,2700038814614,0,2,1000
```

7. 판매한 상품
판매번호,결제방식,결제금액,카드번호,승인번호
```
1,현금,16800,NULL,NULL
3,현금,3100,NULL,NULL
4,현금,5700,NULL,NULL
5,현금,15200,NULL,NULL
```


