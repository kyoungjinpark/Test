<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board Update</title>
<script type="text/javascript" src="/test/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
<script>
		$(document).ready(function(){
			var boardNo = '${QueryString.boardNo}';
			var data = {"boardNo":boardNo};
			
			$.ajax({url:"/test/json/board/selectOne", data: data})
			.done(function(data){
				var d = JSON.parse(data)
				var dd = d.result;
				console.log(dd);
				$("#title").val(dd.title);
				$("#content").val(dd.content);
				$("#regUser").val(dd.regUser);
						
			});
			$( "form" ).submit(function( event ) {
				  event.preventDefault();
				  var title = $("#title").val();
				  var content = $("#content").val();
				  /* if(title == ""){
					  alert("제목써요");
					  return false;
				  } */
				  if(content == ""){
					  alert("내용써요");
					  return false;
				  }
				  
				  var d = {
						  "title": title,
						  "content": content,
						  "boardNo":boardNo
				  }			
				  
				  $.ajax({ url: "/test/json/board/update", data: d }).done(function(data){
					 console.log(data);
					 var jsonData = JSON.parse(data);
					 if(jsonData.result == 1){
						 alert("성공");
						 location.href = "/test/board/selectOne?boardNo=" + boardNo;
					 }else {
						 alert("실패");
					 }
				  });
				});
		});
</script>
</head>
<body>
 <form>
		<input type="text" name="title" id="title" placeholder="제목"><br>
		<input type="text" name="content" id="content" placeholder="내용"><br>
		<!-- <input type="text" name="regUser" placeholder="사용자번호"><br> -->
		<select name="regUser" id="regUser" disabled>
			<option value="1">관리자</option>
			<option value="2">구디</option>
			<option value="3">김경빈</option>
		</select>
		<input type="submit" value="저장"><br>
		<a href="/test/board/selectOne?boardNo=${QueryString.boardNo}">리스트로 돌아가기</a>
	</form>
</body>
</html>