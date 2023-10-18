
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
// DEFINING FUNCTIONS

const showToast = (message, isSuccess) => {
	const toastElm = $("#toast");
	toastElm.text(message)
	toastElm.removeClass("hidden")
	toastElm.addClass(`block ${isSuccess ? "bg-green-500" : "bg-red-500"}`)

	setTimeout(function() {
		toastElm.removeClass(`block ${isSuccess ? "bg-green-500" : "bg-red-500"}`)
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

const handleSubmitReport = () => {
	const reportContent = reportTextarea.val();
	$.ajax({
		type: "POST",
		url: "report-question",
		data: { questionID, reportContent },
		success: function(isReported) {
			if (isReported) {
				reportTextarea.val("")
				closeReportModal()
				showToast("Your report has been saved!")
			}
		},
		error: function() {
			alert("Failed to submit.");
		},
	});
}

const handleUpvote = () => {
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

// EVENT HANDLING

reportContentContainer.click(function(event) {
	event.stopPropagation();
});

reportBtn.click(openReportModal)
reportCloseBtn.click(closeReportModal)
reportModal.click(closeReportModal)
reportSubmitBtn.click(handleSubmitReport)
upvoteBtn.click(handleUpvote)
downvoteBtn.click(handleDownvote)
