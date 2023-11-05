function handleConfirmNotification() {
	const hasNewFollower = $(this).data("hasnewfollower");
	const hasQuestionInteraction = !hasNewFollower;
	const notificationID = $(this).data("notificationid");
	const followerID = $(this).data("followerid");
	const questionID = $(this).data("questionid");

	if (hasNewFollower) {
		window.location.href = `user-profile?userID=${followerID}`;
	}

	if (hasQuestionInteraction) {
		window.location.href = `question-detail?question_id=${questionID}`;
	}

	$.ajax({
		type: "POST",
		url: "check-notification",
		data: { notificationID },
		success: function(isChecked) {
			
		},
		error: function() {
			alert("Failed to submit.");
		},
	});
}
$(".notification-item").click(handleConfirmNotification)
