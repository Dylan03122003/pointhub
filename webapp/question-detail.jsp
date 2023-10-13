<%@page import="model.Question"%>
<%@page import="util.Authentication"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;1,100;1,200&family=Roboto:wght@100;300;400;500;700&family=Rubik:wght@300;400;500;600&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="question-detail-style.css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer src="js/question-detail-script.js"></script>
    
    <style >
    
    .modal {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7);
}

.modal-content {
  background-color: #fff;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  padding: 20px;
}

.close {
  position: absolute;
  top: 0;
  right: 0;
  padding: 10px;
  cursor: pointer;
}
    </style>
  </head>
  
  <%
  Question question = (Question) session.getAttribute("questionDetail");
  boolean isLoggedIn = (boolean) Authentication.isLoggedIn(request);
  %>

  <body class="">
  
   <!-- <button onclick="showToast('Your report has been saved!')" class="bg-blue-500 hover:bg-blue-600 text-white p-2 rounded m-4">Show Toast</button>
    <div id="toast" class="hidden bg-green-500 text-white fixed top-0 right-0 m-4 p-2 rounded shadow show">
    </div> -->
  
	<div id="modalOverlay" class="fixed inset-0 bg-black opacity-50 hidden"></div>
	
	<!-- Modal Container -->
	<div id="customModal" class="fixed inset-0 flex items-center justify-center hidden">
	  <div class="modal-content bg-white p-4 rounded-lg shadow-lg w-1/2">
	    <span id="closeModalButton" class="text-3xl absolute top-0 right-0 m-2 cursor-pointer text-gray-600 hover:text-gray-800">&times;</span>
	    <h2 class="text-2xl font-semibold mb-4">Report</h2>
	    
	    <form id="reportForm" >
	       <textarea
            name="reportContent"
            class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"
          ></textarea>
          <input id="submitBtn" class="px-4 py-1 bg-blue-400 rounded-md text-white" type="submit"/>
	    </form>
	  </div>
	</div>
  
    <!-- <c:if test="${violated_unique_vote}">
      <h2>You have already voted this question!</h2>
    </c:if> -->
    <jsp:include page="navbar.jsp" />

    <div class="w-[320px] sm:w-[600px] md:w-[800px] lg:w-[1000px] mx-auto">
      <div class="p-10 bg-white">
        <div class="flex item-center justify-between">
          <div class="flex items-center justify-start gap-3">
            <img
              src="https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80"
              alt=""
              class="w-[50px] h-[50px] object-cover rounded-full"
            />
            <div class="profile_info">
              <p>@<%=question.getUsername()%></p>
              <p><%=question.getCreatedAt()%></p>
            </div>
          </div>
         <div class="sm:block hidden">
            <button
                 id="openModalButton"
                 class="bg-red-400 text-white px-4 py-1 rounded-md"
               >
              Report
            </button>
          <button
            class="${questionDetail.isBookmarked() ? 'red-button' : 'white-button'}  bg-orange-400 text-white px-4 py-1 rounded-md"
          >
            Bookmark
          </button>
         </div>
        </div>

        <h2 class="mt-10 font-bold text-2xl text-gray-600">
          <%=question.getTitle()%>
        </h2>

        <p class="mt-5"><%=question.getQuestionContent()%></p>

        <div class="mt-10 flex items-center justify-start gap-2">
          <c:forEach var="tag" items="<%=question.getTagContents()%>">
            <span class="px-4 py-1 rounded-md bg-red-50">${tag}</span>
          </c:forEach>
        </div>

        <div class="mt-10 flex items-center gap-2">
          <a
            class=""
            href="vote-question?questionId=<%=question.getQuestionID()%>&voteType=upvote"
            >Upvote</a
          >
          <p><%=question.getVotesSum()%></p>

          <a
            href="vote-question?questionId=<%=question.getQuestionID()%>&voteType=downvote"
            >Downvote</a
          >
        </div>
         <div class="flex gap-4">
             <button
                 class="mt-10 sm:hidden block bg-red-400 text-white px-4 py-1 rounded-md"
               >
              Report
             </button>
             <button
            class="${questionDetail.isBookmarked() ? 'red-button' : 'white-button'} mt-10 sm:hidden block bg-orange-400 text-white px-4 py-1 rounded-md"
             >
             Bookmark
           </button>
         </div>
      </div>

      <div
        class="bg-white mt-10 p-4 flex flex-col gap-2 items-center justify-center"
      >
        <h2 class="font-medium text-xl">Comment</h2>
        <form
          class="w-full flex flex-col gap-4 justify-center items-end"
          action="create-comment"
          method="post"
        >
          <textarea
            name="comment"
            class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"
          ></textarea>
          <input
            type="hidden"
            name="question_id"
            value="${questionDetail.getQuestionID()}"
          />
          <button
            class="px-4 py-1 rounded-md bg-orange-400 text-white"
            type="submit"
          >
            Comment
          </button>
        </form>
      </div>

      <div class="p-10 mt-10 bg-white">
        <c:forEach var="comment" items="<%=question.getComments()%>">
          <div>
            <div class="flex items-center justify-start gap-3 mb-5">
              <img
                src="https://images.unsplash.com/photo-1480429370139-e0132c086e2a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1888&q=80"
                alt=""
                class="w-[50px] h-[50px] object-cover rounded-full"
              />
              <div class="profile_info">
                <a href="#">@${comment.getUsername()}</a>
                <p>${comment.getCreatedAt()}</p>
              </div>
            </div>

            <p class="mb-4">${comment.getCommentContent()}</p>

            <div class="flex items-center justify-start gap-4">
              <div>
                <button class="text-yellow-600">Like</button>
                <span>12</span>
              </div>
              <div>
                <button class="text-yellow-600">Dislikes</button>
                <span>12</span>
              </div>
              <button
                class="reply-button text-gray-600"
                data-comment-id="${comment.getCommentID()}"
                onclick="toggleReplyForm(${replyComment.getCommentID()})"
              >
                Reply
              </button>
            </div>

            <!-- Reply Form -->
            <form
              action="reply-comment"
              method="post"
              class="mt-5"
              id="replyForm-${comment.getCommentID()}"
              style="display: none"
            >
              <input
                type="hidden"
                name="comment_id"
                value="${comment.getCommentID()}"
              />
              <input
                type="hidden"
                name="user_id"
                value="${comment.getUserID()}"
              />
              <input
                type="hidden"
                name="question_id"
                value="${questionDetail.getQuestionID()}"
              />
              <textarea
                name="replyContent"
                rows="3"
                cols="30"
                class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"
                placeholder="Write your reply"
              ></textarea>
              <button type="submit">Submit</button>
            </form>

            <a
              href="show-replies?commentID=${comment.getCommentID()}"
              class="text-gray-600"
              >View replies</a
            >

            <div class="p-4">
              <c:forEach
                var="replyComment"
                items="${comment.getReplyComments()}"
              >
                <div
                  class="border-l-8 pl-5 p-2 mb-5 border border-solid border-blue-400"
                >
                  <div class="flex items-center justify-start gap-3 mb-5">
                    <img
                      src="https://images.unsplash.com/photo-1480429370139-e0132c086e2a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1888&q=80"
                      alt=""
                      class="w-[50px] h-[50px] object-cover rounded-full"
                    />
                    <div class="profile_info">
                      <a href="#">@${replyComment.getUsername()}</a>
                      <p>${replyComment.getCreatedAt()}</p>
                    </div>
                  </div>
                  <p>
                    <a href="" class="font-medium"
                      >@${replyComment.getUsernameReply()}</a
                    >
                    ${replyComment.getReplyContent()}
                  </p>

                  <div class="flex items-center justify-start gap-4">
                    <div>
                      <button class="text-yellow-600">Like</button>
                      <span>3</span>
                    </div>
                    <div>
                      <button class="text-yellow-600">Dislikes</button>
                      <span>4</span>
                    </div>
                    <button
                      class="nested-reply-btn text-gray-600"
                      data-reply-id="${replyComment.getReplyID()}"
                    >
                      Reply
                    </button>
                  </div>
                </div>

                <form
                  action="reply-comment"
                  method="post"
                  class="reply-form"
                  style="display: none"
                  id="nestedReplyForm-${replyComment.getReplyID()}"
                >
                  <input
                    type="hidden"
                    name="comment_id"
                    value="${comment.getCommentID()}"
                  />
                  <input
                    type="hidden"
                    name="user_id"
                    value="${replyComment.getUserID()}"
                  />
                  <input
                    type="hidden"
                    name="question_id"
                    value="${questionDetail.getQuestionID()}"
                  />
                  <textarea
                    name="replyContent"
                    rows="3"
                    cols="30"
                    class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"
                    placeholder="Write your reply"
                  ></textarea>
                  <button type="submit">Submit</button>
                </form>
              </c:forEach>
            </div>
          </div>
        </c:forEach>
        <a class="text-gray-600" href="load-comment">View more comments</a>
      </div>
    </div>

    <script>
     

    </script>
  </body>
</html>
