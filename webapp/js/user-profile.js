let about = document.getElementById("about");
let question = document.getElementById("question");
let aboutNav = document.getElementById("about-nav");
let questionNav = document.getElementById("posts-nav");
let btnfollow = document.getElementById("follow-btn");

// TEMPLATES

function renderPost(post) {

	const userProfileID = $("body").data("userprofileid");

	let tagElements = "";

	for (const tag of post.tagContents) {
		tagElements += `<div>${tag}</div>`;
	}

	return `

<a href="question-detail?question_id=${post.questionID}&user_id=${userProfileID}"
						class="card">
		<div class="card-body">
							<h5 class="card-title">${post.title}</h5>
							<p>Topic: ${post.topicName}</p>
							<p>Votes: ${post.voteSum}</p>
							<div class="card-tags">

								${tagElements}

							</div>
						</div>
		<div class="card-footer text-muted">${post.createdAt}</div>
</a>	
	
`
}


// FUNCTION HANDLERS

const handleShowNav = (event) => {

	let element = event.target.getAttribute("data-target");
	let content = document.getElementById(element);
	about.style.display = "none";
	question.style.display = "none";
	questionNav.style.opacity = "0.5";
	aboutNav.style.opacity = "0.5";

	content.style.display = "block";
	event.target.style.opacity = "1";
}

function handleFollowUser() {
	const followedUserID = $("body").data("userprofileid");
	const button = $(this);
	const followersSumElm = $("#followers-sum");
	$.ajax({
		type: "GET",
		url: "follow-user?followedUserID=" + followedUserID,
		dataType: "json",
		success: function(isFollowed) {
			const followersSum = parseInt(followersSumElm.text())
			if (isFollowed) {
				button.text("Following");
				followersSumElm.text(followersSum + 1)
				btnfollow.style.background = "#9E9E9E";
			} else {
				button.text("Follow");
				followersSumElm.text(followersSum - 1)
				btnfollow.style.background = "#F48023";
			}

		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

function handleShowUserPosts() {
	const userProfileID = $("body").data("userprofileid");

	$.ajax({
		type: "GET",
		url: `view-user-questions?userID=${userProfileID}`,
		dataType: "json",
		success: function(userPosts) {
			// questionID, title, createdAt, tagContents, voteSum, topicName
			$(".card-container").empty();

			let userPostTemplates = ""
			for (const post of userPosts) {
				userPostTemplates += renderPost(post);
			}
			$(".card-container").data("userpostssize", userPosts.length)
			$(".card-container").append(userPostTemplates)
		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

function handleLoadMoreQuestions() {
	const userPostsSize = $(".card-container").data("userpostssize");
	const userProfileID = $("body").data("userprofileid");

	$.ajax({
		type: "GET",
		url: `view-user-questions?userID=${userProfileID}&currentPostSize=${userPostsSize}`,
		dataType: "json",
		success: function(userPosts) {
			// questionID, title, createdAt, tagContents, voteSum, topicName
			let userPostTemplates = ""
			for (const post of userPosts) {
				userPostTemplates += renderPost(post);
			}
			$(".card-container").data("userpostssize", userPostsSize + userPosts.length)
			$(".card-container").append(userPostTemplates)
		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

// EVENT HANDLERS --------------------------------------------------------------------------------------------

$("#about-nav").click(handleShowNav)

$("#posts-nav").click(function(event) {
	handleShowNav(event)
	handleShowUserPosts()
})


if (btnfollow && btnfollow.innerText == "Following") {
	btnfollow.style.background = "#9E9E9E";
}

$("#follow-btn").click(handleFollowUser)

$(".load-more-btn").click(handleLoadMoreQuestions)
