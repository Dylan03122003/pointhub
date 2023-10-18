

const renderReply = (reply, currentUserID) => {
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
      <a href="#">@${reply.username}</a>
      <p>${reply.createdAt}</p>
    </div>
  </div>
  <p>
    <a href="" class="font-medium"
      >@${reply.usernameReply}</a
    >
    ${reply.replyContent}
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



const renderComment = (comment, currentUserID) => {


	return `
<div class= "comment-item mb-10" data-commentID="${comment.commentID}">
  <div class="flex items-center justify-start gap-3">
    <img
      src="img/${comment.userPhoto}"
      alt=""
      class="w-[50px] h-[50px] object-cover rounded-full"
    />
    <div class="profile_info">
      <a href="#">@${comment.username}</a>
      <p>${comment.createdAt}</p>
    </div>
  </div>

  <p class="my-4">${comment.commentContent}</p>

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


// Response return
// commentID, replyContent, replyID, userID, userReplyID, username, usernameReply
const replyComment = (questionID, commentID, userReplyID, replyContent, currentUserID) => {
	const data = {
		questionID: questionID,
		commentID: commentID,
		userReplyID: userReplyID,
		replyContent: replyContent,
	};

	$.ajax({
		type: "POST",
		url: "reply-comment",
		data: data,
		success: function(data) {
			const replyTemplate = renderReply(data, currentUserID)
			const repliesContainers = $(".replies-container")
			repliesContainers.each(function(index, repliesContainer) {
				const containerCommendID = $(repliesContainer).data("commentid")

				if (containerCommendID === data.commentID) {
					$(repliesContainer).append(replyTemplate)
				}
			});
		},
		error: function() {
			alert("Failed to submit the reply.");
		},
	});
};

const viewMoreReplies = (commentID, repliesSize, currentUserID) => {
	const data = {
		commentID: commentID,
		repliesSize: repliesSize
	}
	$.ajax({
		type: "POST",
		url: "view-replies",
		data: data,
		success: function(data) {

			const repliesContainer = $(`.replies-container[data-commentID="${commentID}"]`);

			const replyItems = repliesContainer.find(".reply-item");

			const currentReplyIDs = []

			replyItems.each(function() {
				const replyID = $(this).data("replyid");
				currentReplyIDs.push(replyID);
			});

			let replyTemplates = "";
			for (const reply of data) {
				if (!currentReplyIDs.includes(reply.replyID)) replyTemplates += renderReply(reply, currentUserID)
			}

			repliesContainer.append(replyTemplates)
		},
		error: function() {
			alert("Failed to view replies.");
		},
	});

}
// Response return
// commentContent, commentID, createdAt, questionID, replyComments, userID, username
const getDefaultComments = (questionID, currentUserID) => {
	$.ajax({
		type: "GET",
		url: "view-default-comments?questionID=" + questionID,
		dataType: "json",
		success: function(data) {
			let commentsTemplate = "";
			for (let i = 0; i < data.length; i++) {
				commentsTemplate += renderComment(data[i], currentUserID);
			}

			$("#comments-container").append(commentsTemplate);

			$(".view-comments").data("commentsize", data.length);
		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
};

const viewMoreComments = (questionID, currentUserID, currentCommentSize) => {

	const data = {
		questionID: questionID,
		currentCommentSize: currentCommentSize
	}

	$.ajax({
		type: "POST",
		url: "view-comments",
		data: data,
		dataType: "json",
		success: function(data) {
			if (data) {
				const currentCommentItems = $(".comment-item");
				const currentCommentIDs = []
				currentCommentItems.each(function() {
					const commentID = $(this).data("commentid");
					currentCommentIDs.push(commentID);
				});

				if (!currentCommentIDs.includes(data.commentID)) {
					const commentTemplate = renderComment(data, currentUserID);
					$("#comments-container").append(commentTemplate);
					$(".view-comments").data("commentsize", currentCommentSize + 1);
				}

			}

		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

const createComment = (questionID, currentUserID, commentContent) => {

	const data = {
		questionID: questionID,
		commentContent: commentContent
	}

	$.ajax({
		type: "POST",
		url: "create-comment",
		data: data,
		dataType: "json",
		success: function(data) {
			const commentTemplate = renderComment(data, currentUserID);
			$("#comments-container").append(commentTemplate);
			$(".comment-content").val("")
		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

const closeModal = () => {
	$(".reply-modal").removeClass("flex");
	$(".reply-modal").addClass("hidden");
}

const openModal = () => {
	$(".reply-modal").removeClass("hidden");
	$(".reply-modal").addClass("flex");
}


// START TO LISTEN FOR EVENTS ----------------------------------------------------------------------
$(document).ready(function() {
	const questionID = $("body").data("questionid");
	const currentUserID = $("body").data("userid");

	getDefaultComments(questionID, currentUserID);


	// Handle replying comments ---------------------------------
	$(document).on("click", ".reply-button", function() {
		const commentID = $(this).data("commentid");
		const userReplyID = $(this).data("userreplyid");
		$(".reply-modal").removeClass("hidden");
		$(".reply-modal").addClass("flex");
		$(".reply-submit-btn").data("commentid", commentID);
		$(".reply-submit-btn").data("userreplyid", userReplyID);
	});

	// Handle replying replies ---------------------------------
	$(document).on("click", ".nested-reply-btn", function() {
		const commentID = $(this).data("commentid");
		const userReplyID = $(this).data("userid");
		const replyThemselves = userReplyID === currentUserID

		if (replyThemselves) {

		} else {
			openModal()
			$(".reply-submit-btn").data("commentid", commentID);
			$(".reply-submit-btn").data("userreplyid", userReplyID);
		}

	});
	// Handle viewing more replies ---------------------------------
	$(document).on("click", ".view-replies-btn", function() {
		const commentID = $(this).data("commentid");
		const repliesSize = Number.parseInt($(this).data("repliessize"));
		viewMoreReplies(commentID, repliesSize, currentUserID);

		let currentRepliesSize = parseInt($(this).data("repliessize"));

		currentRepliesSize += 2;

		$(this).data("repliessize", currentRepliesSize);

	});

	// Handle closing modal ---------------------------------
	$(".modal-close-btn").click(function() {
		$(".reply-modal").removeClass("flex");
		$(".reply-modal").addClass("hidden");
	});

	$(".reply-modal").click(function() {
		closeModal()
	});

	// Handle stopping propagation ---------------------------------
	$(".reply-container").click(function(event) {
		event.stopPropagation();
	});

	// Handle submitting reply ---------------------------------
	$(".reply-submit-btn").click(function() {
		const commentID = $(".reply-submit-btn").data("commentid");
		const userReplyID = $(".reply-submit-btn").data("userreplyid");
		const replyContent = $(".reply-content").val();

		replyComment(questionID, commentID, userReplyID, replyContent, currentUserID);
		$(".reply-content").val("");
		closeModal();

		const viewRepliesBtn = $(`.view-replies-btn[data-commentID="${commentID}"]`)

		// THERE IS A BUG HERE
		//let currentRepliesSize = parseInt(viewRepliesBtn.data("repliessize"));
		//currentRepliesSize += 1;
		//viewRepliesBtn.data("repliessize", currentRepliesSize);

	});

	// Handle commenting 
	$(".comment-btn").click(function() {
		const commentContent = $(".comment-content").val()
		if (commentContent.trim())
			createComment(questionID, currentUserID, commentContent)
	})

	// Handle viewing more comments
	$(".view-comments").click(function() {
		const currentCommentSize = parseInt($(this).data("commentsize"));
		viewMoreComments(questionID, currentUserID, currentCommentSize)
	})
});
