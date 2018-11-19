$(document).ready(function(){
	$.get(
			"https://www.googleapis.com/youtube/v3/channels",{
				part: 'contentDetails',
				id:'UC5hkr9yi8Uh8tJJZKRQIg0A',
				key: 'AIzaSyD9SRVgTdcC5lqNIvhRcvu7SVCA2hYy6cc'},
				function(data){
					$.each(data.items, function(i, item){
						console.log(item);
						pid = item.contentDetails.relatedPlaylists.uploads;
						getVids(pid);
					})
				}
		);

		function getVids(pid){
			$.get(
			"https://www.googleapis.com/youtube/v3/playlistItems",{
				part: 'snippet',
				maxResults:6,
				playlistId:pid,
				key: 'AIzaSyD9SRVgTdcC5lqNIvhRcvu7SVCA2hYy6cc'},
				function(data){
					var output;
					$.each(data.items, function(i, item){
						console.log(item);
						videoTitle = item.snippet.title;
						videoId = item.snippet.resourceId.videoId;

						output = '<li><iframe src=\"//www.youtube.com/embed/'+videoId+'\"></iframe><li>';

						$('#results').append(output);
					})
				}
		);

		}
});