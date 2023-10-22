
const questionID = $("body").data("questionid");
const currentUserID = $("body").data("userid");
const reportModal = $("#report-modal");
const reportOverlay = $("#report-overlay");
const reportBtn = $(".report-btn");
const reportCloseBtn = $("#report-close-btn");
const reportContentContainer = $(".report-content-container");
const reportTextarea = $(".report-textarea");
const reportSubmitBtn = $(".report-submit-btn");
const upvoteBtn = $(".upvote-btn")
const downvoteBtn = $(".downvote-btn")
const votesSum = $(".votes-sum")
const requireLoginModal = $(".require-login-modal")
// DEFINING FUNCTIONS

const showToast = (message, isSuccess) => {
	const toastElm = $("#toast");
	toastElm.text(message)
	toastElm.removeClass("hidden")
	toastElm.addClass(`block`)
	if (isSuccess) {
		toastElm.addClass(`bg-green-500`)
	} else {
		toastElm.addClass(`bg-red-500`)
	}

	setTimeout(function() {
		toastElm.removeClass(`block`)
		toastElm.removeClass(`bg-red-500`)
		toastElm.removeClass(`bg-green-500`)
		toastElm.addClass("hidden")
	}, 3000);

}

const closeReportModal = () => {
	reportOverlay.removeClass("block");
	reportOverlay.addClass("hidden");
	reportModal.removeClass("flex");
	reportModal.addClass("hidden");
}

const openReportModal = () => {
	reportOverlay.removeClass("hidden");
	reportOverlay.addClass("block");
	reportModal.removeClass("hidden");
	reportModal.addClass("flex");
}

export const openRequireLoginModal = () => {
	requireLoginModal.removeClass("hidden");
	requireLoginModal.addClass("flex");
}

const closeRequireLoginModal = () => {
	requireLoginModal.removeClass("flex");
	requireLoginModal.addClass("hidden");
}

const handleSubmitReport = () => {
	const reportContent = reportTextarea.val();
	if (!reportContent.trim()) {
		return;
	}

	$.ajax({
		type: "POST",
		url: "report-question",
		data: { questionID, reportContent },
		success: function(isReported) {
			if (isReported) {
				reportTextarea.val("")
				closeReportModal()
				showToast("Your report has been saved!", true)
			}
		},
		error: function() {
			alert("Failed to submit.");
		},
	});
}

const handleUpvote = () => {

	if (currentUserID === -1) {
		openRequireLoginModal()
		return
	}

	$.ajax({
		type: "GET",
		url: `vote-question?questionId=${questionID}&voteType=upvote`,
		dataType: "json",
		success: function(isVoted) {
			if (isVoted) {
				const currentSum = parseInt(votesSum.text());
				votesSum.text(currentSum + 1);
			} else {
				showToast("You have already upvoted this question", false)
			}
		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

const handleDownvote = () => {
	if (currentUserID === -1) {
		openRequireLoginModal()
		return
	}

	$.ajax({
		type: "GET",
		url: `vote-question?questionId=${questionID}&voteType=downvote`,
		dataType: "json",
		success: function(isVoted) {
			if (isVoted) {
				const currentSum = parseInt(votesSum.text());
				votesSum.text(currentSum - 1);
			} else {
				showToast("You have already downvoted this question", false)
			}
		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

const handleOpenReportModal = () => {
	if (currentUserID !== -1) {
		openReportModal()
		return
	}

	openRequireLoginModal()

}

// EVENT HANDLING

reportContentContainer.click(function(event) {
	event.stopPropagation();
});

$(".require-login-content").click(function(event) {
	event.stopPropagation();
})

reportBtn.click(handleOpenReportModal)
reportCloseBtn.click(closeReportModal)
reportModal.click(closeReportModal)
reportSubmitBtn.click(handleSubmitReport)

upvoteBtn.click(handleUpvote)
downvoteBtn.click(handleDownvote)

requireLoginModal.click(closeRequireLoginModal)
$(".require-login-close-btn").click(closeRequireLoginModal)
