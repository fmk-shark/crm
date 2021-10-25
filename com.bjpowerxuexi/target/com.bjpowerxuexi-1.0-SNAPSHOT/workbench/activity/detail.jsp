<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});
		$("#edit-editBtn").click(function () {
				if(confirm("确定要变更以下数据吗")){
					$.ajax({
						url:"workbench/activity/edit.do",
						type:"post",
						data:{
							"owner":"${sessionScope.user.name}",
							"id":"${a.id}",
							"name":$.trim($("#edit-marketActivityName").val()),
							"startDate":$.trim($("#edit-startTime").val()),
							"endDate":$.trim($("#edit-endTime").val()),
							"cost":$.trim($("#edit-cost").val()),
							"description":$.trim($("#edit-describe").val())
						},
						dataType:"json",
						success:function (data) {
							if(data.success){
								$("#editActivityModal").modal("hide");
                                location.reload();
							}else{alert("更改失败了，请检查用户名和名称是否一致");}
						}
					})
				}
		})

		$("#editBtn").click(function () {
				$.ajax({
					url:"workbench/user/edituList.do",
					type:"get",
					data:{
						"id":"${a.id}"}
					,
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

			})

		$("#remarkBody").on("mouseover",".remarkDiv",function(){
			$(this).children("div").children("div").show();
		})
		$("#remarkBody").on("mouseout",".remarkDiv",function(){
			$(this).children("div").children("div").hide();
		})
		showRemarkList();

        $("#saveRemark").click(function () {
            $.ajax({
                url:"workbench/activityRemark/saveRemark.do",
                type:"get",
                data:{
                    "createBy":"${sessionScope.user.name}",
                    "activityId":"${a.id}",
                    "noteContent":$.trim($("#remark").val())
                },
                dataType:"json",
                success:function (data) {
                  if(data.success){
                     $("#remark").val("");
                      let html = "";
                          html += '<div id ='+data.saveRemarkMap.id+' class="remarkDiv" style="height: 60px;">'
                          html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">'
                          html += '<div style="position: relative; top: -40px; left: 40px;" >'
                          html += '<h5 id="e'+data.saveRemarkMap.id+'">'+data.saveRemarkMap.noteContent+'</h5>'
                          html += '<font color="gray">市场活动</font> <font color="gray">-</font> <b>${a.name}</b> <small style="color: gray;" id="t'+data.saveRemarkMap.id+'" >'+(data.saveRemarkMap.editFlag == 0?data.saveRemarkMap.createTime:data.saveRemarkMap.editTime)+' ' +
                              '由'+(data.saveRemarkMap.editFlag == 0?data.saveRemarkMap.createBy:data.saveRemarkMap.editBy)+'</small>'
                          html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">'
                          html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+data.saveRemarkMap.id+'\')><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>'
                          html += '&nbsp;&nbsp;&nbsp;&nbsp;'
                          html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+data.saveRemarkMap.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>'
                          html += '</div>'
                          html += '</div>'
                          html += '</div>'
                      $("#remarkDiv").before(html);
                  }else{

                  }
                }
            })
        })

        $("#updateRemarkBtn").click(function () {
           let id = $("#remarkId").val();
            $.ajax({
                url:"workbench/activityRemark/updateRemark.do",
                type:"get",
                data:{
                    "noteContent":$.trim($("#noteContent").val()),
                    "id":id,
                    "editBy":"${sessionScope.user.name}"
                },
                dataType:"json",
                success:function (data) {
                  if(data.success){
                       $("#e"+id).html(data.activityRemark.noteContent);
                       $("#t"+id).html((data.activityRemark.editFlag == 0?data.activityRemark.createTime:data.activityRemark.editTime)
                           +' 由'+(data.activityRemark.editFlag == 0?data.activityRemark.createBy:data.activityRemark.editBy));
                       $("#editRemarkModal").modal("hide");
                  }else{alert("修改失败。")}
                }
            })
        })
	});
    function editRemark(id) {
        //alert(id);
        //将id用隐藏域保存起来，方便调用
        $("#remarkId").val(id);

        let content = $("#e"+id).html();
        $("#noteContent").val(content);
        $("#editRemarkModal").modal("show");
    }

	function deleteRemark(id) {
		$.ajax({
			url:"workbench/activityRemark/deleteRemark.do",
			type:"get",
			data:{
				"id":id
			},
			dataType:"json",
			success:function (data) {
                if(data.success){
                    $("#"+id).remove();
                }else{alert("删除失败。")}

			}
		})
	}
		function showRemarkList(){
			$.ajax({
				url:"workbench/activityRemark/showRemarkList.do",
				type:"get",
				data:{
					"activityId":"${a.id}"
				},
				dataType:"json",
				success:function (data) {
                 /*

                 data[备注1{},备注2{}]

                 */

					let html = "";
					$.each(data,function (i,n) {
						html += '<div id ='+n.id+' class="remarkDiv" style="height: 60px;">'
						html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">'
						html += '<div style="position: relative; top: -40px; left: 40px;" >'
						html += '<h5 id="e'+n.id+'">'+n.noteContent+'</h5>'
						html += '<font color="gray">市场活动</font> <font color="gray">-</font> <b>${a.name}</b> <small style="color: gray; " id="t'+n.id+'">'+(n.editFlag == 0?n.createTime:n.editTime)+' 由'+(n.editFlag == 0?n.createBy:n.editBy)+'</small>'
						html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">'
						html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>'
						html += '&nbsp;&nbsp;&nbsp;&nbsp;'
						html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>'
						html += '</div>'
						html += '</div>'
						html += '</div>'
					})
                    $("#detailActivityRemarkDiv").after(html);


				}
			})//语句结束
		}



	
</script>

</head>
<body>
	
	<!-- 修改市场活动备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
		<%-- 备注的id --%>
		<input type="hidden" id="remarkId">
        <div class="modal-dialog" role="document" style="width: 40%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">修改备注</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="noteContent" ></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
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
                    <h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
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
                                <input type="text" class="form-control" id="edit-startTime" >
                            </div>
                            <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-endTime" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-cost" value="5,000">
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

	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>市场活动-${a.name} <small>${a.startDate} ~ ${a.endDate}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default"  id="editBtn"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;" id=""><b>${a.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${a.name}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.startDate}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${a.endDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.cost}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${a.owner}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${a.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${a.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${a.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${a.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 30px; left: 40px;" id="remarkBody">
		<div class="page-header" id="detailActivityRemarkDiv">
			<h4>备注</h4>
		</div>


		<!-- 备注1 -->

		<!-- 备注2 -->
		<%--<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>呵呵！</h5>
				<font color="gray">市场活动</font> <font color="gray">-</font> <b>发传单</b> <small style="color: gray;"> 2017-01-22 10:20:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>--%>
		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="saveRemark">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>