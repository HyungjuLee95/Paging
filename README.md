# paging
paging 처리 진행
---
##### Q 비동기 처리와 동기 처리의 차이

##### 추가적으로 예정
  1. 동기처리로 진행하는 페이징 -> 페이징 관련
  2. 댓글 대댓글 (완, 업로드 예정)
  3. 파일 업로드 및 저장
  4. 서버 관련 설정 
---
---
## 작동화면
### 1. 최초 화면
##### <a href="https://ibb.co/xH3zhdJ"> 사진 자료 1</a>

---
### 2. 버튼 누를 시 3개의 항목 추가 표시

##### <a href="https://ibb.co/88Jx0z2"> 사진 자료 2</a>
---
---
### #페이징 처리 방법
1. ajax이용하여 진행
2. data 처리는 myBatis를 통해 mapper/sqlsession으로 처리
3. 비동기 통신으로 진행하여 더보기 버튼을 누르면 추가적으로 5개씩 출력이 되는 기능 구현




<code 부분의 경우에는 포인트 부분만 >
### #code
---
## 1.controller
---
```
@ResponseBody
	@RequestMapping(value = "/json_PagingSelectAll.do", method = RequestMethod.GET)
	public List<PagingVO> json_PagingSelectAll() {
		log.info("PagingSelectAll.do().....{}");
		

		
		List<PagingVO> vos = service.selectAll();
		log.info("Paging().....{}", vos);

	
	

		return vos;

	
}
```
---
## 2.model
---
```
//impl
@Override
	public List<PagingVO> selectAll() {
		log.info("selectAll in DAOimpl()...");
		return sqlsession.selectList("Paging_SELECT_ALL");
	}
	
//mapper.xml

<mapper namespace="text.com.paging">
	<select id="Paging_SELECT_ALL"
		resultType="text.com.paging.Model.PagingVO">
		select * from paging
	</select>

//oracleDriver는 properties file로 따로 빼서 처리 
oracle.DRIVER_NAME=oracle.jdbc.OracleDriver
oracle.URL=jdbc:oracle:thin:@localhost:1521:xe
oracle.USER=JAVA
oracle.PASSWORD=hi123456

	

```
---
## 3. Service
---
```

		@Autowired
	PagingDAO dao;
	
	public List<PagingVO> selectAll(){
		return dao.selectAll() ;
	}
}
	

```
---
 ## 4. js
---
```

function loadMoreItems() {
			$.ajax({
				url : "json_PagingSelectAll.do", // json 목록 가져오기
				method : "GET",
				data : {
					page : currentPage,
					itemsPerPage : itemsPerPage
				},
				dataType : "json",
				success : function(response) {
					//불러온 항목 처리 및 가공, 출력(html에 추가) 
					var items = response;
					var html = "";
					var startIndex = (currentPage - 1)
							* itemsPerPage;
					var endIndex = startIndex
							+ itemsPerPage;

					if (startIndex >= items.length) {
						// 요청한 페이지에 추가 항목이 없는 경우
						$(".more_but").hide();
						alert("더 이상 내용이 없습니다.");

						return;
					}

					if (endIndex > items.length) {
						// 마지막 페이지에서 아이템의 인덱스 조정
						endIndex = items.length;
					}

					for (var i = startIndex; i < endIndex; i++) {
						var vo = items[i];

						html += '<li>';
						html += '<h3>';
						html += '<a href="cs_notice_selectOne.do?num=' + vo.num + '">' + vo.title + '</a>';
						html += '</h3>';
						html += '</li>';
					
					}

					$(".ajaxLoop").append(html); // 가져온 항목을 추가합니다
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			});
}


```
---
## 5.SQL 
---
```
CREATE TABLE PAGING 
(
  NUM NUMBER NOT NULL 
, TITLE VARCHAR2(100 BYTE) 
, CONTENT VARCHAR2(100 BYTE) 
, USER_ID VARCHAR2(100 BYTE) 
, CONSTRAINT PAGING_PK PRIMARY KEY 
  (
    NUM 
  )
  USING INDEX 
  (
      CREATE UNIQUE INDEX PAGING_PK ON PAGING (NUM ASC) 
      LOGGING 
      TABLESPACE SYSTEM 
      PCTFREE 10 
      INITRANS 2 
      STORAGE 
      ( 
        INITIAL 65536 
        NEXT 1048576 
        MINEXTENTS 1 
        MAXEXTENTS UNLIMITED 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
      ) 
      NOPARALLEL 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE SYSTEM 
PCTFREE 10 
PCTUSED 40 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL;



```
---

