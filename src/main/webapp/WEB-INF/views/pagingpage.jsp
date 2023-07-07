<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var currentPage = 1; // 시작 페이지 번호
						var itemsPerPage = 3; //표시 항목 수

						$(".more_but").click(function() {
							currentPage++; // 페이지 번호 증가
							loadMoreItems();
						});

						function loadMoreItems() {
							$
									.ajax({
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
					});
</script>



<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<div class="notice_List" style="height: auto;">
		<h2>Paging 연습장</h2>
		<c:forEach items="${vos}" var="vo" varStatus="loop">
			<c:if test="${loop.index < 5}">

				<ul>
					<li>
						<h3>
							<a href="#">${vo.title}</a> <input type="hidden" name="num"
								value="${vo.num}">
						</h3>
					</li>
				</ul>
			</c:if>

		</c:forEach>
		<ul>
			 <div class="ajaxLoop">
      </div>
      </ul>
		<div class="more_but_position">
			<button class="more_but">더 보기 ></button>
		</div>


	</div>



</body>
</html>