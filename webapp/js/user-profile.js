let about = document.getElementById("about");
let question = document.getElementById("question");
let bookmark = document.getElementById("bookmark");
const requireLoginModal = $(".require-login-modal")
let aboutNav = document.getElementById("about-nav");
let questionNav = document.getElementById("posts-nav");
let bookmarkNav = document.getElementById("bookmarks-nav");

let btnfollow = document.getElementById("follow-btn");

// TEMPLATES

function renderPost(post) {

	const userProfileID = $("body").data("userprofileid");

	let tagElements = "";

	for (const tag of post.tagContents) {
		tagElements += `<span class="px-4 py-1 rounded-md bg-orange-100 text-orange-500">${tag}</span>`;
	}

	return `

<a href="question-detail?question_id=${post.questionID}&user_id=${userProfileID}"
						class="card">
		<div class="card-body">
							<h5 class="card-title font-bold text-gray-600">${post.title}</h5>
							<p class="text-[12px] text-gray-600">Topic: <span class="text-orange-500">${post.topicName}<span></p>
							<p class="text-[12px] text-gray-600 ">Votes: <span class="text-orange-500">${post.voteSum}</span></p>
							
							<div class="card-tags flex items-center justify-start flex-wrap gap-2">
								${tagElements}
							</div>
							
						</div>
		<div class="card-footer text-muted">${post.createdAt}</div>
</a>	
	
`
}

function renderFollower(follower) {
	return `
				<a href="user-profile?userID=${follower.userID}" class="flex gap-4 mb-5">
					<img class="w-[50px] h-[50px] object-cover rounded-full" alt=""
						src="img/${follower.photo}">
					<div>
						<h2 class="font-medium text-gray-700">@${follower.username}</h2>
						<p class="text-gray-600">${follower.email}</p>
					</div>
				</a>
	
	`
}


// FUNCTION HANDLERS

const handleShowNav = (event) => {
	let element = event.target.getAttribute("data-target");
	let content = document.getElementById(element);
	about.style.display = "none";
	question.style.display = "none";
	bookmark.style.display = "none";
	questionNav.style.opacity = "0.5";
	if (bookmarkNav)
		bookmarkNav.style.opacity = "0.5";
	aboutNav.style.opacity = "0.5";

	content.style.display = "block";
	event.target.style.opacity = "1";
}


function handleFollowUser() {
	const currentUserID = $("body").data("currentuserid");
	if (currentUserID === -1) {
		openRequireLoginModal()
		return
	}

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
			const hasPosts = userPosts.length > 0;
			$(".card-container").empty();

			if (hasPosts) {
				let userPostTemplates = ""
				for (const post of userPosts) {
					userPostTemplates += renderPost(post);
				}
				$(".card-container").data("userpostssize", userPosts.length)
				$(".card-container").append(userPostTemplates)
			} else {
				$(".card-container").append("<p class='text-gray-600 p-5'>There is no posts</p>")
				$(".load-more-post-btn").remove()
			}


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

function handleShowUserBookmarks() {
	const userProfileID = $("body").data("userprofileid");

	$.ajax({
		type: "GET",
		url: `view-bookmarks?userID=${userProfileID}`,
		dataType: "json",
		success: function(userBookmarks) {
			// questionID, title, createdAt, tagContents, voteSum, topicName
			const hasBookmarks = userBookmarks.length > 0;
			$(".card-bookmark-container").empty();
			if (hasBookmarks) {
				let userPostTemplates = ""
				for (const bookmark of userBookmarks) {
					userPostTemplates += renderPost(bookmark);
				}
				$(".card-bookmark-container").data("userbookmarkssize", userBookmarks.length)
				$(".card-bookmark-container").append(userPostTemplates)
			} else {
				$(".card-bookmark-container").append("<p class='text-gray-600 p-5'>There is no bookmarks</p>")
				$(".load-more-bookmark-btn").remove()
			}



		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

function handleLoadMoreBookmark() {
	const userBookmarksSize = $(".card-bookmark-container").data("userbookmarkssize");
	const userProfileID = $("body").data("userprofileid");

	$.ajax({
		type: "GET",
		url: `view-bookmarks?userID=${userProfileID}&currentBookmarkSize=${userBookmarksSize}`,
		dataType: "json",
		success: function(userBookmarks) {
			//userBookmarks contains: questionID, title, createdAt, tagContents, voteSum, topicName
			let userBookmarkTemplates = ""
			for (const bookmark of userBookmarks) {
				userBookmarkTemplates += renderPost(bookmark);
			}
			$(".card-bookmark-container").data("userbookmarkssize", userBookmarksSize + userBookmarks.length)
			$(".card-bookmark-container").append(userBookmarkTemplates)
		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

function showFollowersModal() {
	$(".followers-modal").removeClass("hidden")
	$(".followers-modal").addClass("flex")
}

function closeFollowersModal() {
	$(".followers-modal").removeClass("flex")
	$(".followers-modal").addClass("hidden")
}

function handleShowFollowers() {
	const userProfileID = $("body").data("userprofileid");

	$.ajax({
		type: "GET",
		url: `view-followers?followedUserID=${userProfileID}`,
		dataType: "json",
		success: function(follwers) {
			$(".followers-container").empty()
			const hasFollowers = follwers.length !== 0;
			if (hasFollowers) {
				let followerTemplates = "";
				for (const follower of follwers) {
					followerTemplates += renderFollower(follower);
				}
				$(".followers-container").data("followerssize", follwers.length)
				$(".followers-container").append(followerTemplates);
			} else {
				$(".followers-container").append("<p class='text-gray-600'>There is no followers</p>");
				$(".followers-container").removeClass("overflow-y-scroll");
				$(".view-more-followers-btn").remove();
			}
			showFollowersModal()

		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

function handleViewMoreFollowers() {
	const userProfileID = $("body").data("userprofileid");
	const currentFollowersSize = $(".followers-container").data("followerssize");

	$.ajax({
		type: "GET",
		url: `view-followers?followedUserID=${userProfileID}&followersSize=${currentFollowersSize}`,
		dataType: "json",
		success: function(follwers) {
			let followerTemplates = ""
			for (const follower of follwers) {
				followerTemplates += renderFollower(follower);
			}
			$(".followers-container").data("followerssize", currentFollowersSize + follwers.length)
			$(".followers-container").append(followerTemplates)
		},
		error: function() {
			alert("Failed to load data from the server.");
		},
	});
}

export const openRequireLoginModal = () => {
	requireLoginModal.removeClass("hidden");
	requireLoginModal.addClass("flex");
}

const closeRequireLoginModal = () => {
	requireLoginModal.removeClass("flex");
	requireLoginModal.addClass("hidden");
}

// EVENT HANDLERS --------------------------------------------------------------------------------------------

$(".followers-content").click(function(event) {
	event.stopPropagation();
});

$(".require-login-content").click(function(event) {
	event.stopPropagation();
})


$("#about-nav").click(handleShowNav)

$("#posts-nav").click(function(event) {
	handleShowNav(event)
	handleShowUserPosts()
})

$("#bookmarks-nav").click(function(event) {
	handleShowNav(event)
	handleShowUserBookmarks()
})

if (btnfollow && btnfollow.innerText == "Following") {
	btnfollow.style.background = "#9E9E9E";
}

$("#follow-btn").click(handleFollowUser)

$(".load-more-post-btn").click(handleLoadMoreQuestions)
$(".load-more-bookmark-btn").click(handleLoadMoreBookmark)

$(".followers-modal").click(closeFollowersModal)
$(".followers-modal-btn").click(closeFollowersModal)
$(".view-more-followers-btn").click(handleViewMoreFollowers)

requireLoginModal.click(closeRequireLoginModal)
$(".require-login-close-btn").click(closeRequireLoginModal)
$("#followers-sum-container").click(handleShowFollowers)