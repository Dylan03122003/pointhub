
import { renderReply, renderComment } from "./template.js"
import { openRequireLoginModal } from "./main-question-detail.js"



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
			console.log(data)
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
			console.log(data)
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

		if (currentUserID === -1) {
			openRequireLoginModal()
			return;
		}

		const commentID = $(this).data("commentid");
		const userReplyID = $(this).data("userreplyid");
		$(".reply-modal").removeClass("hidden");
		$(".reply-modal").addClass("flex");
		$(".reply-submit-btn").data("commentid", commentID);
		$(".reply-submit-btn").data("userreplyid", userReplyID);
	});

	// Handle replying replies ---------------------------------
	$(document).on("click", ".nested-reply-btn", function() {

		if (currentUserID === -1) {
			openRequireLoginModal()
			return;
		}

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
		if (currentUserID === -1) {
			openRequireLoginModal()
			return;
		}
		const commentContent = $(".comment-content").val()
		if (commentContent.trim())
			createComment(questionID, currentUserID, commentContent)
	})

	// Handle viewing more comments
	$(".view-comments").click(function() {
		const currentCommentSize = parseInt($(this).data("commentsize"));
		viewMoreComments(questionID, currentUserID, currentCommentSize)
	})

	// Handle like comment
	$(document).on("click", ".like-comment-btn", function() {
		if (currentUserID === -1) {
			openRequireLoginModal()
			return;
		}

		const commentID = $(this).data("commentid");

		$.ajax({
			type: "POST",
			url: "like-comment",
			data: {
				commentID,
				currentUserID
			},
			dataType: "json",
			success: function(isLiked) {
				const likeSumElm = $(`.like-sum[data-commentID="${commentID}"]`);
				const likeSum = parseInt(likeSumElm.text());

				if (isLiked) {
					likeSumElm.text(likeSum + 1)

				} else {
					likeSumElm.text(likeSum - 1)
				}

			},
			error: function() {
				alert("Failed to load data from the server.");
			},
		});
	});

	// Handle dislike comment
	$(document).on("click", ".dislike-comment-btn", function() {
		if (currentUserID === -1) {
			openRequireLoginModal()
			return;
		}

		const commentID = $(this).data("commentid");

		$.ajax({
			type: "POST",
			url: "dislike-comment",
			data: {
				commentID,
				currentUserID
			},
			dataType: "json",
			success: function(isDisliked) {
				const dislikeSumElm = $(`.dislike-sum[data-commentID="${commentID}"]`);
				const dislikeSum = parseInt(dislikeSumElm.text());

				if (isDisliked) {
					dislikeSumElm.text(dislikeSum + 1)
				} else {
					dislikeSumElm.text(dislikeSum - 1)
				}

			},
			error: function() {
				alert("Failed to load data from the server.");
			},
		});
	});

	// Handle like reply
	$(document).on("click", ".like-reply-btn", function() {

		if (currentUserID === -1) {
			openRequireLoginModal()
			return;
		}

		const replyID = $(this).data("replyid");
		const commentID = $(this).data("commentid");

		$.ajax({
			type: "POST",
			url: "like-reply",
			data: {
				replyID,
				currentUserID,
				commentID
			},
			dataType: "json",
			success: function(isLiked) {
				const likeSumElm = $(`.like-sum[data-replyid="${replyID}"]`);
				const likeSum = parseInt(likeSumElm.text());

				if (isLiked) {
					likeSumElm.text(likeSum + 1)
				} else {
					likeSumElm.text(likeSum - 1)
				}

			},
			error: function() {
				alert("Failed to load data from the server.");
			},
		});
	});


	// Handle dislike reply
	$(document).on("click", ".dislike-reply-btn", function() {

		if (currentUserID === -1) {
			openRequireLoginModal()
			return;
		}

		const replyID = $(this).data("replyid");
		const commentID = $(this).data("commentid");

		$.ajax({
			type: "POST",
			url: "dislike-reply",
			data: {
				replyID,
				currentUserID,
				commentID
			},
			dataType: "json",
			success: function(isDisliked) {
				const dislikeSumElm = $(`.dislike-sum[data-replyid="${replyID}"]`);
				const dislikeSum = parseInt(dislikeSumElm.text());

				if (isDisliked) {
					dislikeSumElm.text(dislikeSum + 1)
				} else {
					dislikeSumElm.text(dislikeSum - 1)
				}

			},
			error: function() {
				alert("Failed to load data from the server.");
			},
		});

	});
});
