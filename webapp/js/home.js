
export const showToastInHomePage = (message, isSuccess) => {
	console.log("hello")
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