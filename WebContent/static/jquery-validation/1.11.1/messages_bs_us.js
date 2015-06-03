/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: US (English)
 */
jQuery.extend(jQuery.validator.messages, {
        required: "Cannot be empty",
		remote: "Please correct the field",
		email: "Please enter correct format email",
		url: "Please enter legal internet address ",
		date: "Please enter legal date",
		dateISO: "Please enter legal date(ISO).",
		number: "Please enter legal number",
		digits: "Please enter integer",
		creditcard: "Please enter legal credit cart No",
		equalTo: "Please enter the same value again",
		accept: "Please enter character string with legal extensions",
		maxlength: jQuery.validator.format("Please enter character string with largest length{0}"),
		minlength: jQuery.validator.format("Please enter character string with shortest length{0}"),
		rangelength: jQuery.validator.format("Please enter character string which length between {0} and {1}"),
		range: jQuery.validator.format("Please enter a value between {0} and {1}"),
		max: jQuery.validator.format("Please enter a number which maximum value is {0}"),
		min: jQuery.validator.format("Please enter a number which minimum value is {0}")
});

jQuery.extend(jQuery.validator.defaults, {
    errorElement: "span"
});