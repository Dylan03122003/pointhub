<%@page import="model.Question"%>
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
  </head>

  <body class="bg-[#c4c4c4]">
    <!-- <c:if test="${violated_unique_vote}">
      <h2>You have already voted this question!</h2>
    </c:if> -->

    <div class="w-[1000px] mx-auto">
      <div class="p-10 bg-white">
        <div class="flex item-center justify-between">
          <div class="flex items-center justify-start gap-3">
            <img
              src="https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1965&q=80"
              alt=""
              class="w-[50px] h-[50px] object-cover rounded-full"
            />
            <div class="profile_info">
              <p>@${questionDetail.getUsername()}</p>
              <p>${questionDetail.getCreatedAt()}</p>
            </div>
          </div>

          <button
            class="${questionDetail.isBookmarked() ? 'red-button' : 'white-button'}"
          >
            Bookmark
          </button>
        </div>

        <h2 class="mt-10">${questionDetail.getTitle()}</h2>

        <p class="mt-5">
          ${questionDetail.getQuestionContent()}
        </p>

        <div class="mt-10 flex items-center justify-start gap-2">
          <c:forEach var="tag" items="${questionDetail.getTagContents()}"> 
           <span class="px-4 py-1 rounded-md bg-red-50">${tag}</span>
         </c:forEach>
        </div>

        <div class="mt-10 flex items-center gap-2">
          <a
            class=""
            href="vote-question?questionId=${questionDetail.getQuestionID()}&voteType=upvote"
            >Upvote</a
          >
          <p>10</p>

          <a
            href="vote-question?questionId=${questionDetail.getQuestionID()}&voteType=downvote"
            >Downvote</a
          >
        </div>
      </div>

      <div
        class="bg-white mt-10 p-4 flex flex-col gap-2 items-center justify-center"
      >
        <h2>Comment</h2>
        <form
          class="flex flex-col gap-4 justify-center items-end"
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
          <button class="px-4 py-1 rounded-md bg-blue-400" type="submit">
            Comment
          </button>
        </form>
      </div>

      <div class="p-10 mt-10 bg-white">
        <c:forEach var="comment" items="${questionDetail.getComments()}">
          <div>
            <div class="flex items-center justify-start gap-3 mb-5">
              <img
                src="https://images.unsplash.com/photo-1480429370139-e0132c086e2a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1888&q=80"
                alt=""
                class="w-[50px] h-[50px] object-cover rounded-full"
              />
              <div class="profile_info">
                <p>@DuongQuoc</p>
                <p>03/12/2023</p>
              </div>
            </div>

            <p class="mb-4">
              Lorem ipsum dolor sit amet consectetur adipisicing elit.
              Consequatur magnam dolor rerum numquam illum quidem eligendi
              veritatis autem fuga nemo incidunt labore corrupti dolorem placeat
              exercitationem ratione nisi, neque illo!
            </p>

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
                class="px-4 py-1 rounded-md bg-blue-400"
                onclick="toggleReplyForm(${comment.getCommentID()})"
              >
                Reply
              </button>
            </div>

            <a
              href="show-replies?commentID=${comment.getCommentID()}"
              class="text-gray-600"
              >View replies</a
            >

            <!-- Reply Form -->
            <form
              action="reply-comment"
              method="post"
              class=""
              id="replyForm-${comment.getCommentID()}"
              style="display: none"
            >
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
                placeholder="Write your reply"
              ></textarea>
              <button type="submit">Submit</button>
            </form>

            <div class="p-4">
              <c:forEach
                var="replyComment"
                items="${comment.getReplyComments()}"
              >
                <div
                  class="border-l-8 border border-solid border-blue-400 pl-5 p-2"
                >
                  <div class="flex items-center justify-start gap-3 mb-5">
                    <img
                      src="https://images.unsplash.com/photo-1480429370139-e0132c086e2a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1888&q=80"
                      alt=""
                      class="w-[50px] h-[50px] object-cover rounded-full"
                    />
                    <div class="profile_info">
                      <p>@XuanNguyen</p>
                      <p>03/12/2023</p>
                    </div>
                  </div>
                  <p>
                    <span class="font-medium">@DuongQuoc</span> Lorem ipsum
                    dolor sit amet consectetur adipisicing elit. Provident aut
                    in necessitatibus! Quae, provident a! Aspernatur quis
                    facere, debitis id adipisci tenetur animi enim minima!
                    Aliquid blanditiis est nostrum illo!
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
                      class="px-4 py-1 rounded-md bg-blue-400"
                      onclick="toggleReplyForm(${replyComment.getCommentID()})"
                    >
                      Reply
                    </button>
                  </div>
                </div>

                <form
                  class="reply-form"
                  style="display: none"
                  id="replyForm-${replyComment.getCommentID()}"
                >
                  <textarea
                    name="replyContent"
                    rows="3"
                    cols="30"
                    placeholder="Write your reply"
                  ></textarea>
                  <button type="submit">Submit</button>
                </form>
              </c:forEach>
            </div>
          </div>
        </c:forEach>
        <a href="load-comment">View more comments</a>
      </div>
    </div>

    <script>
      function toggleReplyForm(commentId) {
        const replyForm = document.getElementById(`replyForm-${commentId}`);
        if (
          replyForm.style.display === "none" ||
          replyForm.style.display === ""
        ) {
          replyForm.style.display = "block";
        } else {
          replyForm.style.display = "none";
        }
      }
    </script>
  </body>
</html>
