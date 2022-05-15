<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Customer Inquiry</title>
	
    
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>
	                    <div>Inquiry List</div>
	                    <div>
	                        <div id="inquiryDiv">
	                    	
	            			</div>
	                    </div>
	                    
	                   
<div id="hideDiv" style="display: none">
    <form id="inquiry">
    <input type="hidden" id="edit_id" name="edit_id">
           <div>
	                                <label>Account ID</label>
	                                <div>
	                                    <input type="text" id="account_id" class="form-control" name="account_id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Customer Name</label>
	                                <div>
	                                    <input type="text" id="name" class="form-control" name="name">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Customer ID</label>
	                                <div>
	                                    <input type="text" id="c_id" class="form-control" name="c_id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Customer Phone Number</label>
	                                <div>
	                                    <input type="text" id="c_phone" class="form-control" name="c_phone">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>NIC</label>
	                                <div>
	                                    <input type="text" id="c_nic" class="form-control" name="c_nic">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Customer Email</label>
	                                <div>
	                                    <input type="email" id="email" class="form-control" name="email">
	                                </div>
	                            </div>
	                            
	                             <div>
	                                <label>Description</label>
	                                <div>
	                                    <input type="text" id="description" class="form-control" name="description">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Type</label>
	                                <div>
	                                    <select name="type" class="form-control" id="type">
	                                		<option value="">Select</option>
	                                		<option value="Power cut">Power cut</option>
	                                		<option value="Repair">Repair </option>
	                                		<option value="Bill issue">Bill issuer</option>
	                                		<option value="Other">Other</option>
	                                	</select>
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Date</label>
	                                <div>
	                                    <input type="date" id="date" class="form-control" name="date">
	                                </div>
	                            </div>
          
          <div>
              <button type="submit" class="btn btn-success">
                  Edit
              </button>
          </div>
  	</form>
</div> 
	                    
</div>
	
</body>
</html>

<script>

    function deletes(id) {
    	if (confirm("Do you want to delete ?") == true) {
        	$.ajax({
                type: "DELETE",
                url: "rest_api/inquiries",
                data: JSON.stringify({ 'id' : id}),
                dataType: "json",
    			contentType : 'application/json',
                success: function(data){
                	if(data['success']=="Done"){
                		alert("Delete Successfull!");
    					reload();
    				}else if(data['success']=="0"){
    					alert("Delete Unsuccessful!");
    				}
                },
                failure: function(errMsg) {
                    alert('Error');
                }
            });
    	}
    }

    $(document).ready(function () {

        $("#inquiry").validate({
        	rules: {
        		account_id: "required",
            	name: "required",
                c_id: "required",
                c_phone: "required",
                c_nic: "required",
                email: {
                    email: true,
                    required: true
                },
                description: "required",
                type: "required",
                date: "required"
            },
            messages: {
            	account_id: "Accunt ID Required!",
            	name: "Name Required!",
                c_id: "Customer ID Required!",
                c_phone: "Customer phone number Required!",
                c_nic: "Customer NIC Required!",
                email: {
                    email: "format",
                    required: "Customer Email required!"
                },
                description: "Description Required!",
                type: "Type Required!",
                date: "Date required!"
            },
            submitHandler: function () {
            	var fromData = JSON.stringify({
            		"id" : $('#edit_id').val(),
            		"account_id" : $('#account_id').val(),
                    "name" : $('#name').val(),
                    "c_id" : $('#c_id').val(),
                    "c_phone" : $('#c_phone').val(),
                    "c_nic" : $('#c_nic').val(),
                    "email" : $('#email').val(),
                    "description" : $('#description').val(),
                    "type" : $('#type').val(),
                    "date" : $('#date').val()
                });
            	
            	console.log(fromData);

                $.ajax({
                    type: "PUT",
                    url: 'rest_api/inquiries',
                    dataType : 'json',
    				contentType : 'application/json',
    				data: fromData,
                    success: function(data){
                    	if(data['success']=="Done"){
                    		alert("Edit Successfull!");
                        	document.getElementById("hideDiv").style.display = "none";
                            $("#inquiry")[0].reset();
    						reload();
    					}else{
    						alert("Unsuccessful!");
    					}
                    },
                    failure: function(errMsg) {
                    	alert("Connection Error!");
                    }
                });
            }
        });

        $("#inquiry").submit(function(e) {
            e.preventDefault();
        });

    });

    function reload(){
    	$.ajax({
            type: "GET",
            url: "rest_api/inquiries",
            success: function(data){
            	$("#inquiryDiv").html(data);
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }

    reload();
    
    function edit(id) {
    	document.getElementById("hideDiv").style.display = "block";
    	$.ajax({
            type: "POST",
            url: "rest_api/inquiries/get",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
            	console.log(data),
                $('#edit_id').val(data['id']),
                $('#account_id').val(data['account_id']),
                $('#name').val(data['name']),
                $('#c_id').val(data['c_id']),
                $('#c_phone').val(data['c_phone']),
                $('#c_nic').val(data['c_nic']),
                $('#email').val(data['email']),
                $('#description').val(data['description']),
                $('#type').val(data['type']),
                $('#date').val(data['date'])
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });

        
    }
    
    
</script>