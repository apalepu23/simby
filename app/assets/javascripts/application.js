// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require dropzone

$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;

	var dropzone = $(".dropzone").dropzone({
		autoProcessQueue: true, 
		maxFilesize: 256, // Set the maximum file size to 256 MB
		paramName: "listing[photo]", // Rails expects the file upload to be something like model[field_name]
		addRemoveLinks: false // Don't show remove links on dropzone itself.
	});	

	dropzone.on("success", function(file, response) {
		this.removeFile(file)
		$.getScript("/seller/listings")
	})

	$(".imgLiquidFill").imgLiquid({
		fill: true; 
	});
});


