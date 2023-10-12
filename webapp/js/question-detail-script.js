/**
 * 
 */


// Define the toggleReplyForm function outside the DOMContentLoaded event listener
function toggleReplyForm(commentId) {
	const replyForm = document.getElementById("replyForm-" + commentId);
	if (
		replyForm.style.display === "none" ||
		replyForm.style.display === ""
	) {
		replyForm.style.display = "block";
	} else {
		replyForm.style.display = "none";
	}
}

function toggleNestedReplyForm(replyId) {
	const replyForm = document.getElementById("nestedReplyForm-" + replyId);
	if (
		replyForm.style.display === "none" ||
		replyForm.style.display === ""
	) {
		replyForm.style.display = "block";
	} else {
		replyForm.style.display = "none";
	}
}

document.addEventListener("DOMContentLoaded", function() {
	// Attach a click event listener to all "Reply" buttons on the page
	const replyButtons = document.querySelectorAll(".reply-button");
	const nestedReplyButtons =
		document.querySelectorAll(".nested-reply-btn");
	replyButtons.forEach(function(button) {
		button.addEventListener("click", function(event) {
			// Prevent the default behavior of the button (e.g., form submission)
			event.preventDefault();
			const commentId = button.getAttribute("data-comment-id");

			// Call the toggleReplyForm function with the commentId
			toggleReplyForm(commentId);
		});
	});

	nestedReplyButtons.forEach(function(button) {
		button.addEventListener("click", function(event) {
			// Prevent the default behavior of the button (e.g., form submission)
			event.preventDefault();
			const replyId = button.getAttribute("data-reply-id");

			toggleNestedReplyForm(replyId);
		});
	});

	// Your other JavaScript code here
});



// Get the modal and buttons
const modal = document.getElementById("customModal");
const openButton = document.getElementById("openModalButton");
const closeButton = document.getElementById("closeModalButton");
const overlay = document.getElementById("modalOverlay");


// Open the modal when the button is clicked
openButton.addEventListener("click", () => {
	modal.style.display = "block";
	overlay.style.display = "block";
});

closeButton.addEventListener("click", () => {
	modal.style.display = "none";
	overlay.style.display = "none";
});

// Close the modal when clicking outside the modal content
window.addEventListener("click", (event) => {
	if (event.target === modal) {
		modal.style.display = "none";
		overlay.style.display = "none";
	}
});


function showToast(message) {
	console.log("gello")
	const toast = document.getElementById('toast');
	toast.textContent = message;
	toast.classList.remove('hidden');
	setTimeout(() => {
		toast.classList.add('hidden');
	}, 3000); // Hide the toast after 3 seconds
}