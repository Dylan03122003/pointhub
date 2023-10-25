
const renderReportDetail = (userReported) => {
	return `

			<div
				class="flex items-center justify-around gap-10 mb-5 border-[1px] border-solid border-gray-200 rounded-md p-2">
				<a href="user-profile?userID=${userReported.userID}" class="w-[30%] flex items-center gap-2">
					<img class="w-14 h-14 object-cover rounded-full" alt=""
						src="img/${userReported.photo}">
					<div>
						<p class="text-gray-500 font-medium">${userReported.username}</p>
						<p class="text-gray-500 ">${userReported.email}</p>
					</div>
					
				</a>

				<p class="w-[70%] text-gray-600">${userReported.reportContent}</p>
			</div>	
	
`
}

const openReportDetailModal = () => {
	$(".report-detail-modal").removeClass("hidden");
	$(".report-detail-modal").addClass("flex");

}

const closeReportDetailModal = () => {
	$(".report-detail-modal").removeClass("flex");
	$(".report-detail-modal").addClass("hidden");

}

// EVENT HANDLERS

$(".report-detail-container").click(function(event) {
	event.stopPropagation();
});

$(".see-report-detail-btn").click(function() {
	const questionID = $(this).data("questionid")
	$.ajax({
		type: "GET",
		url: `report-detail?questionID=${questionID}`,
		dataType: "json",
		success: function(usersReported) {
			$(".reports-detail").empty()
			openReportDetailModal()
			let reportTemplates = "";
			for (let i = 0; i < usersReported.length; i++) {
				reportTemplates += renderReportDetail(usersReported[i]);
			}

			$(".reports-detail").append(reportTemplates);
			$(".reports-detail").data("reportsdetailsize", usersReported.length)
			$(".reports-detail").data("questionid", questionID)

		},
		error: function() {
			alert("Failed to submit.");
		},
	});
})

$(".report-detail-close-btn").click(closeReportDetailModal)

$(".report-detail-modal").click(closeReportDetailModal)

$(".view-more-reports-btn").click(function() {
	const reportsDetailSize = $(".reports-detail").data("reportsdetailsize")
	const questionID = $(".reports-detail").data("questionid")

	$.ajax({
		type: "GET",
		url: `report-detail?questionID=${questionID}&reportsDetailSize=${reportsDetailSize}`,
		dataType: "json",
		success: function(usersReported) {
			const hasMoreReports = usersReported.length !== 0;
			if(!hasMoreReports) return;
			let reportTemplates = "";
			for (let i = 0; i < usersReported.length; i++) {
				reportTemplates += renderReportDetail(usersReported[i]);
			}

			$(".reports-detail").append(reportTemplates);
			$(".reports-detail").data("reportsdetailsize", usersReported.length + reportsDetailSize)
		},
		error: function() {
			alert("Failed to submit.");
		},
	});

})
