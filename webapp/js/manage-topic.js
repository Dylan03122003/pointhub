
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

function handleDuplicateTopic() {
	const isDuplicatedTopic = $(".add-topic-form").data("duplicatedtopic")
	if (isDuplicatedTopic) {
		showToast("That topic already existed!")
	}
}

function handleUpdateTopic() {
	const topicContainer = $(this).closest('div[data-topicid]');
	const topicNameElm = topicContainer.find('.topic-name');
	const topicID = topicContainer.data('topicid');
	const updateButton = $(this); // Save a reference to the "Update" button

	// Create an input field to edit the topic name
	const topicNameInput = $("<input>").attr({
		type: "text",
		class: "border-[1px] border-solid border-gray-400",
		value: topicNameElm.text()
	});

	// Create a "Save" button
	const saveButton = $("<button>").attr({
		type: "button",
		class: "bg-blue-400 text-white px-3 py-1 rounded-md"
	}).text("Save");

	// Create a "Cancel" button
	const cancelButton = $("<button>").attr({
		type: "button",
		class: "bg-slate-400 text-white px-3 py-1 rounded-md"
	}).text("Cancel");



	// Replace the topic name element with the input field
	topicNameElm.replaceWith(topicNameInput, saveButton);

	topicContainer.append(cancelButton)

	// Hide the "Update" button
	updateButton.addClass("hidden")

	// Add a click event handler to the "Save" button
	saveButton.on("click", function() {
		const updatedTopicName = topicNameInput.val();

		$.ajax({
			type: "POST",
			url: "update-topic",
			data: {
				topicName: updatedTopicName,
				topicID
			},
			success: function(isDuplicatedTopicname) {
				if (isDuplicatedTopicname) {
					showToast("Duplicated topic name!", false)
					topicNameInput.replaceWith(topicNameElm);
					saveButton.remove();
					cancelButton.remove();
					updateButton.removeClass("hidden");
				} else {
					showToast("Updated successfully!", true)
					topicNameElm.text(updatedTopicName)
					topicNameInput.replaceWith(topicNameElm);
					saveButton.remove();
					cancelButton.remove();
					updateButton.removeClass("hidden");
				}
			},
			error: function() {
				alert("Failed to submit the reply.");
			},
		});



	});

	cancelButton.on("click", function() {
		topicNameInput.replaceWith(topicNameElm);
		saveButton.remove();
		cancelButton.remove();
		updateButton.removeClass("hidden"); // Show the "Update" button using the reference
	});
}


// EVENT HANDLER 

handleDuplicateTopic()

$(".update-topic-btn").click(handleUpdateTopic)
