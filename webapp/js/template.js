
export const renderReply = (reply, currentUserID) => {
	return `
  <div data-replyid="${reply.replyID}" class="reply-item border-l-8 pl-5 p-2 mb-5 border border-solid border-blue-400"
>
  <div class="flex items-center justify-start gap-3 mb-5">
    <img
      src="img/${reply.userPhoto}"
      alt=""
      class="w-[50px] h-[50px] object-cover rounded-full"
    />
    <div class="profile_info">
      <a href="user-profile?userID=${reply.userID}">@${reply.username}</a>
      <p>${reply.createdAt}</p>
    </div>
  </div>
  <p>
    <a href="user-profile?userID=${reply.userReplyID}" class="font-medium"
      >@${reply.usernameReply}</a
    >
    ${reply.replyContent}
  </p>

  <div class="flex items-center justify-start gap-4">
    <div>
      <button data-commentID="${reply.commentID}" data-replyid="${reply.replyID}" class="like-reply-btn text-yellow-600">Like</button>
      <span data-replyid="${reply.replyID}" class="like-sum" >${reply.likes}</span>
    </div>
    <div>
      <button data-commentID="${reply.commentID}" data-replyid="${reply.replyID}" class="dislike-reply-btn text-yellow-600">Dislikes</button>
      <span data-replyid="${reply.replyID}" class="dislike-sum">${reply.dislikes}</span>
    </div>
    <button
      class="nested-reply-btn text-gray-600 ${reply.userID === currentUserID ? 'hidden' : 'block'}"
      data-commentID="${reply.commentID}"
      data-userReplyID="${reply.userReplyID}"
      data-userID="${reply.userID}"
      data-reply-id="${reply.replyID}"
    >
      Reply
    </button>
  </div>
</div>
  `;
};


export const renderComment = (comment, currentUserID) => {


	return `
<div class= "comment-item mb-10" data-commentID="${comment.commentID}">
  <div class="flex items-center justify-start gap-3">
    <img
      src="img/${comment.userPhoto}"
      alt=""
      class="w-[50px] h-[50px] object-cover rounded-full"
    />
    <div class="profile_info">
      <a href="user-profile?userID=${comment.userID}">@${comment.username}</a>
      <p>${comment.createdAt}</p>
    </div>
  </div>

  <p class="my-4">${comment.commentContent}</p>

  <div class="flex items-center justify-start gap-4">
    <div>
      <button data-commentID="${comment.commentID}" class="like-comment-btn text-yellow-600">Like</button>
      <span data-commentID="${comment.commentID}" class="like-sum">${comment.likes}</span>
    </div>
    <div>
      <button data-commentID="${comment.commentID}" class="dislike-comment-btn text-yellow-600">Dislikes</button>
      <span data-commentID="${comment.commentID}" class="dislike-sum">${comment.dislikes}</span>
    </div>
     <button
        class="reply-button ${comment.userID === currentUserID ? 'hidden' : 'block'}"
         type="button"
         data-commentID="${comment.commentID}"
         data-userReplyID="${comment.userID}"
              >
        Reply
    </button>
  </div>
  
   <button 
    class="view-replies-btn"
    data-repliesSize="${0}"
    data-commentID="${comment.commentID}"
   >View more replies</button>
     
    <!-- Replies Container ------------------------------------------------------------>
    <div data-commentID="${comment.commentID}" class="replies-container p-5"></div>
</div>
`;
};