let about = document.getElementById("about");
let question = document.getElementById("question");
let aboutNav = document.getElementById("about-nav");
let questionNav = document.getElementById("posts-nav");
let btnfollow = document.getElementById("follow-btn");

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

function handleFollowUser () {
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

function handleShowUserPosts () {
	const userProfileID = $("body").data("userprofileid");
	
	$.ajax({
		type: "GET",
		url: `view-user-questions?userID=${userProfileID}`,
		dataType: "json",
		success: function(userPosts) {
		   console.log(userPosts)
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