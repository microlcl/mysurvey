

<div style="display: none">
	<div id="pt_question">
		<div class="accordion-heading">
			<span style="padding-left: 8px">Q{showId}:</span> {question}
		</div>
		<input type="hidden" name="paper.questions[{myindex}].id" value="{id}">
	</div>
	<div id="pt_questionBody">
		<div class="accordion-inner" style="padding-left: 55px">{content}</div>
	</div>

	<div id="pt_radioQuestion">
		<label class="radio"> <input type="radio" name="paper.questions[{myindex}].questionOptions" value="{myValue}"> {content}
		</label>
	</div>

	<div id="pt_checkboxQuestion">
		<label class="checkbox"> <input type="checkbox" name="paper.questions[{myindex}].questionOptions" value="{myValue}">
			{content}
		</label>
	</div>
	<div id="pt_openQuestion">
		<textarea name="paper.questions[{myindex}].questionOptions"></textarea>
	</div>
</div>

<script>
	var questionTemp = $('#pt_question').html();
	var radioTemp = $('#pt_radioQuestion').html();
	var checkBoxTemp = $('#pt_checkboxQuestion').html();
	var openQuestTemp = $('#pt_openQuestion').html();
	var optionBodyTemp = $('#pt_questionBody').html();

	function loadPaper(paperId, renderDevId) {
		console.log("in loadPaper");
		$('#paper_content').empty();
		$.ajax({
			url : '${ctx}/paper/api/getQuestions/' + paperId,
			type : 'get',
			success : function(resp) {
				console.log(resp);

				$.each(resp, function(i, question) {
					console.log("===================");
					console.log(question);
					question.myindex = i;	
					question.showId = i + 1;			
					var q = nano(questionTemp,question);
					var questionBody = buildQuestions(i,question);
					$('#' + renderDevId).append(q + questionBody);

				});

			}
		});

	}
	
	function buildQuestions(myindex, question) {		
		//radio question:
		var result = "";
		console.log("question.questionType = " + question.questionType);
		if (question.questionType == '1') {
			$.each(question.options, function(i, option) {	
				option.myindex = myindex;	
				option.myValue = i + 1;		
				var radioQest = nano(radioTemp,option);	
				result = result + radioQest;		
			})
		}
		// checkbox questions
		if (question.questionType == '2') {
			$.each(question.options, function(i, option) {	
				option.myindex = myindex;
				option.myValue = i + 1;			
				var radioQest = nano(checkBoxTemp,option);	
				result = result + radioQest;		
			})
		}
		if (question.questionType == '3') {
			var myinput = {};
			myinput.myindex = myindex;
			result = result + nano(openQuestTemp,myinput);
			
		}
		var resultObj = {};
		resultObj.content = result;
		return nano(optionBodyTemp, resultObj);
	
	}

</script>

