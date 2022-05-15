<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">

<style>
.row{
margin-top: 2em;
}
.heading{
margin-top: 0.5em;
}



h1 {
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}


.button2 {
padding: 11px 115px;
background-color: #0d6efd;
margin-left: 37%;
margin-top: 5%;
color: white;
}

div {
border-radius: 5px;
background-color: #6748481c;
padding: 20px;
}



.button3 {
padding: 11px 104px;
background-color: #4caf50;
margin-left: 8%;
margin-top: 5%;
color: white;
}

a {
color: #ffffff;
text-decoration: underline;
}

</style>
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

	                    <h1>Inquiry List</h1>
	                        <form id="inquiry">
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
	                                    <input type="number" id="c_phone" class="form-control" name="c_phone">
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
	                                		<option value="Repair">Repair</option>
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
	                                <button class="button3" type="submit" class="btn btn-success">
										Submit Inquiry
										</button >
										<button class="button2" >
										<a href="edit_n_delete.jsp" >
										View Inquiry List
										</a>
										</button>
	                            </div>
	                    	</form>
	                    </div>

</body>
</html>
<script>

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
                type: "POST",
                url: 'rest_api/inquiries',
                dataType : 'json',
				contentType : 'application/json',
				data: fromData,
                success: function(data){
                	console.log(data);
                	if(data['success']=="Done"){
                		alert("Added Successfull!");
                		top.location.href="edit_n_delete.jsp";//rederecting
                        $("#inquiry")[0].reset();
					}else{
						alert("Unsuccessfull!");
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

</script>