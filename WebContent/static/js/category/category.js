var editingId;
var action;

function formatTrashed(value) {
	if (value=='F') {
		return "可用";
	} else {
		return "不可用";
	}
}

function showBtn(value) {
	var btn = '<div><a href="javascript:void(0)"  onclick="save()">保存</a> | <a href="javascript:void(0)"  onclick="cancel()">撤销</a></div>';
	return btn;
}

function onContextMenu(e, row) {
	//只允许没有编辑行的情况下出现右键菜单，避免多行编辑。
	if (editingId) 
		return;
	e.preventDefault();
	$(this).treegrid('select', row.id);
	$('#mm').menu('show', {
		left : e.pageX,
		top : e.pageY
	});
}

function edit() {
	if (editingId != undefined) {
		$('#tg').treegrid('select', editingId);
		return;
	}
	var row = $('#tg').treegrid('getSelected');
	if (row) {
		editingId = row.id;
		console.log("editingId=" + editingId);
		$('#tg').treegrid('beginEdit', editingId);
	}
}

function save() {
	var errorMsg = '';
	if (editingId != undefined) {
		var t = $('#tg');
//		var node = t.treegrid('getSelected');
		var node = t.treegrid('find', editingId);
		t.treegrid('endEdit', editingId);
		if (node.name.trim()=='' || node.name.length > 64) {
			errorMsg = '类别名称校验异常：您可输入1 - 64个字符。';
		}
		if (node.comment.length > 128) {
			errorMsg = '备注校验异常：您可输最多可输入128个字符。';
		}
		
		if (errorMsg != '') {
			console.log(errorMsg);
			$('#successMsgDev').hide();
			$('#errorMsgDev').show();
			$('#errorMsg').html(errorMsg);
			errorMsg = '';			
			$('#tg').treegrid('beginEdit', editingId);
			return;
			
		}
		console.log('in save(), node.id=' + node.id + ",node.name=" + node.name + ",node.comment=" + node.comment);

		$.ajax({
			url : './api/save',
			type: 'post',
			data:{
				id:node.id,
				pid:node._parentId,
				name:node.name.trim(),
				trashed:node.trashed,
				comment:node.comment.trim()
			},
			success : function(resp) {
				console.log('in success function');
				console.log(resp);
				
				editingId = undefined;
				t.treegrid('reloadFooter');
				$('#errorMsgDev').hide();
				$('#successMsgDev').show();				
				$('#successMsg').html("保存成功。");
			}
		});
	}
	
}

function cancel() {
	if (!editingId) {
		return;
	}
	var t = $('#tg');
//	t.treegrid('reload');
	t.treegrid('cancelEdit',editingId);
	if (action == "append") {
		t.treegrid('remove', editingId);	
		action = null;
	}
	
	editingId = null;
}

function append() {
	var node = $('#tg').treegrid('getSelected');
	//get id from server side
	$.ajax({
		url : './api/subId/'+node.id,
		type: 'post',
		success : function(resp) {
			console.log('in success function');
			console.log(resp);
			generateSonNode(node.id,resp);
			action = "append";
		}
	});

}

function generateSonNode(pid,sonId) {
	var d2 = new Date();
	d2.setMonth(d2.getMonth() + 1);
	
	console.log("in generateSonNode():");
	console.log('pid=' + pid + ',sonID=' + sonId);

	$('#tg').treegrid('append', {
		parent : pid,
		data : [ {
			id : sonId,			
			name : '',
			trashed : 'F',
			createdDate : $.fn.datebox.defaults.formatter(d2),
			comment : ''
		} ]
	})
	editingId = sonId;
	$('#tg').treegrid('select', editingId);
	$('#tg').treegrid('beginEdit', editingId);
}
function removeIt() {
	var node = $('#tg').treegrid('getSelected');
	if (node.id.indexOf('1-0')==0) {
		$.messager.alert('Message','系统参数，不能删除');
		return;	
	}
	if (node) {
		children = $('#tg').treegrid('getChildren', node.id);
		console.log('children.length=' + children.length);
		if (children.length > 0) {
			$.messager.alert('Message','请先删除其子节点');
			return;
		}
		$.messager.confirm('Confirm','你确定要删除这个节点吗?',function(r){
			if (r){
				$.ajax({
					url : './api/delete/'+ node.id,
					type: 'delete',
					success : function(resp) {
						console.log('Delete node success:node.id = ' + node.id);
						$('#tg').treegrid('remove', node.id);
						
						editingId = undefined;
						t.treegrid('reloadFooter');
					}
				});	
			}
			});	
	
	}
}
function collapse() {
	var node = $('#tg').treegrid('getSelected');
	if (node) {
		$('#tg').treegrid('collapse', node.id);
	}
}
function expand() {
	var node = $('#tg').treegrid('getSelected');
	if (node) {
		$('#tg').treegrid('expand', node.id);
	}
}

$.extend($.fn.validatebox.defaults.rules, {
	maxLength : {
		validator : function(value, param) {
			return value.length < param[0];
		},
		message : '您最多可以输入 {0} 个字符.'
	}
})