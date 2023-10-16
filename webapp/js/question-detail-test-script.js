/**
 * 
 */

$(document).ready(function() {
	var questionID = $("#load-more-button").data("question-id");
	var currentCommentSize = 1;

	function loadMoreComments() {
		$.ajax({
			type: "GET",
			url: "load-comment",
			data: {
				question_id: questionID,
				current_size: currentCommentSize
			},
			success: function(data) {
				$("#comments-container").empty();

				for (var i = 0; i < data.length; i++) {
					var comment = data[i];

					var commentDiv = $("<div class='comment'></div>");

					var commentContent = $("<p>" + comment.commentContent + "</p>");
					var userInfo = $("<p>Commented by " + comment.username + " on " + comment.createdAt + "</p>");

					commentDiv.append(commentContent);
					commentDiv.append(userInfo);

					$("#comments-container").append(commentDiv);
				}

				currentCommentSize += data.length;
			},
			error: function(error) {
				console.log("Error loading more comments: " + error);
			}
		});
	}

	$("#load-more-button").click(function() {
		loadMoreComments();
	});
});