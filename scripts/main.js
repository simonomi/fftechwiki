function resizeIframe(frame) {
	frame.style.height = 0; // resetting the height to 0 allows it to shrink
	frame.style.height = `max(100%, ${frame.contentDocument.documentElement.scrollHeight}px)`;
}

window.onload = () => {
	Array.from(document.getElementsByTagName("iframe"))
		.forEach(frame => {
			resizeIframe(frame);
			
			frame.onload = () => {
				resizeIframe(frame);
			};
			
			Array.from(frame.contentDocument.getElementsByTagName("details"))
				.forEach(x => x.addEventListener("toggle", event => {
					resizeIframe(frame);
				}));
		});
};
