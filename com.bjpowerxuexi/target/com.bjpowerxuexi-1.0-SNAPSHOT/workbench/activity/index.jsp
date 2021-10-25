<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

	<link href="jquery/bs_pagination/jquery.bs_pagination.min.css" type="text/css" rel="stylesheet">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />


<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){
		pageList(1,5);
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});
       //打开创建模态框窗口
		$("#addBtn").click(function () {

			// 创建datatime组件 为客户规定格式


			$.ajax({
						url:"workbench/user/userlist.do",
						type:"get",
						dataType:"json",
						success:function (data) {
							let html = "<option></option>";

							$.each(data,function (i,n){
                              html += "<option value='"+n.id+"'>"+n.name+"</option>";
							})
							$("#create-marketActivityOwner").html(html);
							let name1 = "${sessionScope.user.id}";
							$("#create-marketActivityOwner").val(name1);
							$("#createActivityModal").modal("show");
						}
					}

			)
		})
       //保存用户数据按钮
		$("#save").click(function () {
			$.ajax({
				url:"workbench/user/save.do",
				type:"post",
				dataType:"json",
				data:{
					"owner":$.trim($("#create-marketActivityOwner").val()),
					"name":$.trim($("#create-marketActivityName").val()),
					"startDate":$.trim($("#create-startTime").val()),
					"endDate":$.trim($("#create-endTime").val()),
					"cost":$.trim($("#create-cost").val()),
					"description":$.trim($("#create-describe").val())
				},
				success:function (data) {
                      if(data.success){
						  $("#activityReset")[0].reset();
						  pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
						  $("#createActivityModal").modal("hide");
					  }else{
                         alert("添加市场活动失败");
					  }
				}
			})
		})
       //修改模态框触发以及数据展示
		$("#editBtn").click(function () {
			let $xz = $("input[name=select-kuang]:checked");
			if($xz.length == 0){
				alert("请选择你要修改的数据");
			}else if($xz.length > 1){
				alert("请勿选择超过一条的数据");
			}else {
					$.ajax({
						url:"workbench/user/edituList.do",
						type:"get",
						data:{
							"id":$("input[name=select-kuang]:checked").val()
						},
						dataType:"json",
						success:function (data) {
							let html = "<option></option>";
							$.each(data.uList,function (i,n){
								html += "<option value='"+n.id+"'>"+n.name+"</option>";
							})
							$("#edit-marketActivityOwner").html(html);

							$("#edit-marketActivityOwner").val(data.activity.owner);
							$("#edit-marketActivityName").val(data.activity.name);
							$("#edit-startTime").val(data.activity.startDate);
							$("#edit-endTime").val(data.activity.endDate);
							$("#edit-cost").val(data.activity.cost);
							$("#edit-describe").val(data.activity.description);
							$("#editActivityModal").modal("show");
						}
					})
		}})
       //隐藏域对象的保存
		$("#search-search").click(function () {
			$("#hidden-name").val($.trim($("#search-name").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-startTime").val($.trim($("#search-startTime").val()));
			$("#hidden-endTime").val($.trim($("#search-endTime").val()));
			pageList($("#activityPage").bs_pagination('getOption', 'currentPage'),$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
		})

        $("#checkbox-selected").click(function () {
				// if($("#checkbox-selected")[0].checked == true){
				// 	let xz = $("input[name=select-kuang]")
				// 	for(let a = 0;a<xz.length;a++){
				// 		xz[a].checked = true;
				// 	}
				// }else{
				// 	let xz = $("input[name=select-kuang]")
				// 	for(let a = 0;a<xz.length;a++){
				// 		xz[a].checked = false;
				// 	}}
			$("input[name=select-kuang]").prop("checked",this.checked);
		})

		$("#table-showData").on("click",$("input[name=select-kuang]"),function () {
			$("#checkbox-selected").prop("checked",$("input[name=select-kuang]").length == $("input[name=select-kuang]:checked").length);
		})

		$("#activity-delete").click(function () {

				let $xz = $("input[name=select-kuang]:checked");
				if($xz.length == 0)
				{alert("你还未选中要删除的对象")}
				else
				{if(confirm("确定要删除选择的数据吗?")){
					let param = "";
					$.each($xz,function (i,n) {
						param += "id="+n.value;
						if(n.value != $xz[$xz.length-1].value){
							param += "&";
						}
					})
					$.ajax({
						url:"workbench/activity/delete.do",
						type:"post",
						data:
						param,
						dataType:"json",
						success:function (data) {
							if(data.success){
								pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
								alert("删除成功");
							}else{
								alert(data.msg);
							}
						}
					})
				}
			}
		})

		$("#edit-editBtn").click(function () {
			let $xz = $("input[name=select-kuang]:checked");
			if($xz.length == 0){
				alert("请选择你要修改的数据");
			}else if($xz.length > 1){
				alert("请勿选择超过一条的数据");
			}else {
				if(confirm("确定要变更以下数据吗")){
					$.ajax({
						url:"workbench/activity/edit.do",
						type:"post",
						data:{
							"owner":"${sessionScope.user.name}",
							"id":$("input[name=select-kuang]:checked").val(),
							"name":$.trim($("#edit-marketActivityName").val()),
							"startDate":$.trim($("#edit-startTime").val()),
							"endDate":$.trim($("#edit-endTime").val()),
							"cost":$.trim($("#edit-cost").val()),
							"description":$.trim($("#edit-describe").val())
						},
						dataType:"json",
						success:function (data) {
							if(data.success){
								pageList($("#activityPage").bs_pagination('getOption', 'currentPage'),$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
								$("#editActivityModal").modal("hide");
								alert("更改成功");
							}else{alert("更改失败了，请检查用户名和名称是否一致");}
						}
					})
				}
			}
		})
        //bootstrap插件为我们提供的分页查询指令
		 /*
		 //操作后停留在当前页面
		 pageList($("#activityPage").bs_pagination('getOption', 'currentPage'));
		 //操作后维持保持已设置好的每页展现的数目
		 pageList($("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

		 */

	});

	// edit-describe edit-cost edit-endTime edit-startTime edit-marketActivityName edit-marketActivityOwner
	function pageList(pageNo,pageSize){
		$("#checkbox-selected").prop("checked",false);

		$("#search-name").val($("#hidden-name").val());
		$("#search-owner").val($("#hidden-owner").val());
		$("#search-startTime").val($("#hidden-startTime").val());
		$("#search-endTime").val($("#hidden-endTime").val());
		$.ajax({
			url:"workbench/user/pagelist.do",
			dataType:"json",
			type:"post",
			data: {
             "pageNo":pageNo,
			 "pageSize":pageSize,
			 "owner":$.trim($("#search-owner").val()),
			 "name":$.trim($("#search-name").val()),
		     "startDate":$.trim($("#search-startTime").val()),
			 "endDate":$.trim($("#search-endTime").val())
			},
			success:function(data) {
				if(data.total>0){
					let html = "<tr class='active' >";
					$.each(data.pageList,function (i,n) {
						html += "<td><input type='checkbox' name='select-kuang' value="+n.id+" /></td>";
						html += "<td><a style='text-decoration: none; cursor: pointer;' onclick=\"window.location.href='workbench/activity/detail.do?id="+n.id+"\';\">"+n.name+"</a></td>";
						html +=	"<td>"+n.owner+"</td>";
						html +=	"<td>"+n.startDate+"</td>";
						html +=	"<td>"+n.endDate+"</td>";
						html +=	"</tr>";
					})
					$("#table-showData").html(html);
				}else{
					alert("傻瓜,表中还没有数据，怎么查")
				}
				// 获取总页数
				let totalPages = data.total%pageSize==0?data.total/pageSize:data.total/pageSize + 1;

				$("#activityPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
						$("#checkbox-selected")[0].checked = false;
					}
				});
			}
		})
	}
</script>
</head>
<body>

    <input type="hidden" id="hidden-owner">
	<input type="hidden" id="hidden-name">
	<input type="hidden" id="hidden-startTime">
	<input type="hidden" id="hidden-endTime">

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="activityReset" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityOwner">
								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-marketActivityName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label ">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startTime" readonly="readonly">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endTime" readonly="readonly">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"  id="save">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner">
								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName" >
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startTime"  readonly="readonly">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endTime"  readonly="readonly">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"  id="edit-editBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control time" type="text" id="search-startTime" readonly="readonly" style="background: white"/>
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control time" type="text" id="search-endTime" readonly="readonly" style="background: white">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="search-search">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn" >
					  <span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn">
					  <span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="activity-delete"><span class="glyphicon glyphicon-minus">
				  </span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkbox-selected"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="table-showData">
						<%--<tr class="active">
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/activity/detail.jsp';">发传单</a></td>
                            <td>zhangsan</td>
							<td>2020-10-10</td>
							<td>2020-10-20</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/activity/detail.jsp';">发传单</a></td>
                            <td>zhangsan</td>
                            <td>2020-10-10</td>
                            <td>2020-10-20</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;" >
               <div id="activityPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>