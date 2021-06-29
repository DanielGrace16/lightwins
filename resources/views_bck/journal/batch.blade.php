@extends('layouts.master')
@section('title')
    {{ trans_choice('general.add',1) }} {{ trans_choice('general.journal',1) }}
@endsection
@section('content')


    <div class="box box-primary" >
        <div class="box-header with-border">
            <h3 class="box-title">{{ trans_choice('general.add',1) }} {{ trans_choice('general.journal',1) }}</h3>

            <div class="box-tools pull-right">
                <button onclick="window.history.back()" class="btn btn-info btn-sm">
                    {{ trans_choice('general.cancel',1) }}
                </button>
            </div>
        </div>
        <form onload="init()" method="post" action="{{url('accounting/journal/store_batch')}}" class="form-horizontal"
              enctype="multipart/form-data">
            {{csrf_field()}}
            <div class="box-body">

                <div class="form-group">
                    <label for="office_id"
                           class="control-label col-md-2">{{trans_choice('general.office',1)}}</label>
                    <div class="col-md-3">
                        <select name="office_id" class="form-control select2" id="office_id" required>
                            <option></option>
                            @foreach(\App\Models\Office::all() as $key)
                                <option value="{{$key->id}}">{{$key->name}}</option>
                            @endforeach
                        </select>
                    </div>
                    <label for="currency_id"
                           class="control-label col-md-2">{{trans_choice('general.currency',1)}}
                    </label>
                    <div class="col-md-3">
                        <select name="currency_id" class="form-control select2" id="currency_id" required>
                            <option></option>
                            @foreach(\App\Models\Currency::where('active',1)->get() as $key)
                                <option value="{{$key->id}}">{{$key->name}}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
                <div class="form-group">
                  
                    <label for="date"
                           class="control-label col-md-2">{{trans_choice('general.date',1)}}</label>
                    <div class="col-md-3">
                        <input type="text" name="date" class="form-control date-picker"
                               value="{{date("Y-m-d")}}"
                               required id="date">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for=""
                           class="control-label col-md-2">{{trans_choice('general.show',1)}} {{trans_choice('general.payment',1)}} {{trans_choice('general.detail',2)}}</label>
                    <div class="col-md-3">
                        <button type="button" class="btn btn-primary" data-toggle="collapse"
                                data-target="#show_payment_details">
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                </div>
                <div id="show_payment_details" class="collapse">
                    <div class="form-group">
                        <label for="payment_type_id"
                               class="control-label col-md-2">{{trans_choice('general.payment',1)}} {{trans_choice('general.type',1)}}
                        </label>
                        <div class="col-md-3">
                            <select name="payment_type_id" class="form-control select2"
                                    id="payment_type_id">
                                <option></option>
                                @foreach(\App\Models\PaymentType::all() as $key)
                                    <option value="{{$key->id}}">{{$key->name}}</option>
                                @endforeach
                            </select>
                        </div>
                        <label for="account_number"
                               class="control-label col-md-2">{{trans_choice('general.account',1)}}
                            #</label>
                        <div class="col-md-3">
                            <input type="text" name="account_number"
                                   class="form-control"
                                   value=""
                                   id="account_number">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="cheque_number"
                               class="control-label col-md-2">{{trans_choice('general.cheque',1)}}
                            #</label>
                        <div class="col-md-3">
                            <input type="text" name="cheque_number"
                                   class="form-control"
                                   value=""
                                   id="cheque_number">
                        </div>

                        <label for="routing_code"
                               class="control-label col-md-2">{{trans_choice('general.routing_code',1)}}</label>
                        <div class="col-md-3">
                            <input type="text" name="routing_code"
                                   class="form-control"
                                   value=""
                                   id="routing_code">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="receipt_number"
                               class="control-label col-md-2">{{trans_choice('general.receipt',1)}}
                            #</label>
                        <div class="col-md-3">
                            <input type="text" name="receipt_number"
                                   class="form-control"
                                   value=""
                                   id="receipt_number">
                        </div>
                        <label for="bank"
                               class="control-label col-md-2">{{trans_choice('general.bank',1)}}
                            #</label>
                        <div class="col-md-3">
                            <input type="text" name="bank"
                                   class="form-control"
                                   value=""
                                   id="bank">
                        </div>
                        
                    </div>
                    
                </div>

                
            </div>
            
            <!-- /.box-body -->

<!------ Include the above in your HEAD tag ---------->

<div class="container">
  <div class="row clearfix">
    <div class="col-md-12">
      <table class="table  table-hover" id="tab_logic" borders ="0">
        <thead>
          <tr>
            <th class="text-center"> # </th>
            <th class="text-center"> Ledger </th>
            <th class="text-center"> </th>
            <th class="text-center"> Loan</th>
            <th class="text-center"> </th>
            <th class="text-center"> Debit </th>
            <th class="text-center"> Credit </th>
            <th class="text-center"> Notes</th>
          </tr>
        </thead>
        <tbody>
          <tr id='addr0'>
            <td>1</td>
            <td>		<button type="button" class="btn btn-success btn-sm btn-add" id="file">
										<span class="glyphicon glyphicon-file" aria-hidden="true"></span>
									</button>
								</span></td>
                                <?php
                                     $branch = Sentinel::getUser()->office_id;
                                    ?>
            <td> <span class="input-group-btn">
							<select name="ledger[]" class="form-control select" id="ledger">
                            <option> --- Select Ledger ---</option>
                            @foreach(\App\Models\GlAccount::all() as $key)
                                <option value="{{$key->id}}">{{$key->name}}</option>
                            @endforeach
                        </select>
                      
                        </td>        
                                    <td><button type="button" class="btn btn-success btn-sm btn-add">
										<span class="glyphicon glyphicon-user" aria-hidden="true" id="user"></span>
									</button>
								</span></td>
                        <td> 
                        <?php
                        $office_id = Sentinel::getUser()->office_id;
                        ?>
                          <select name="loan[]" class="form-control" style="width:250px">
                    <option value="">--- Select Loan ---</option>
                    @foreach(\App\Models\Loan::where('office_id',$office_id)->with('loan_product')->get() as $key)
                                <option value= "{{$key->id}}"> Loan # {{$key->id}}---{{$key->client->external_id}}--- {{$key->client->first_name}} {{$key->client->middle_name}} {{$key->client->last_name}}--- {{$key->loan_product->name}} </option>
                            @endforeach
                </select>
                        </td>
                        

             









            <td><input type="text" id = "debit" name='debit[]' value='0.00' class="form-control debit"/></td>
            <td><input type="text" id = "credit" name='credit[]' value='0.00' class="form-control credit" /></td>
            <td><input type="textarea"  name='notes44[]'class=" form-control" /></td>
          </tr>
          <tr id='addr1'></tr>
        </tbody>
        <tr>
            <th class="text-center"> # </th>
            <th class="text-center">  </th>
            <th class="text-center">  </th>
            <th class="text-center">  </th>
            <th class="text-center"> Totals </th>
            <th class="text-center"> <input type="number" name='total_debit' id="total_debit" placeholder='0.00' class="form-control" readonly/></th>
            <th class="text-center"> <input type="number" name='total_credit' id="total_credit" placeholder='0.00' class="form-control" readonly/> </th>
            <th class="text-center hidden "> Total </th>
          </tr>
      </table>
    </div>
  </div>
  <div class="row clearfix">
    <div class="col-md-12">
      <button id="add_row" class="btn btn-success pull-left" type="button" onclick="add_row();"><i class="fa fa-plus"></i></button>
      <button id='delete_row' class="pull-right btn btn-danger" type="button" ><i class="fa fa-minus"></i></button>
    </div>
  </div>
  <div class="row clearfix" style="margin-top:20px">
    <div class="pull-right col-md-4">
     
    </div>
  </div>
</div>
            <div class="box-footer">
                <div class="heading-elements">
                    <button type="submit" class="btn btn-primary pull-right">{{trans_choice('general.save',1)}}</button>
                </div>
            </div>
        </form>
    </div>
@endsection
@section('footer-scripts')


<script>

 $(document).ready(function(){
     var i=1;
     $("#add_row").click(function(){b=i-1;
        
           $('#addr'+i).html($('#addr'+b).html()).find('td:first-child').html(i+1);
           $('#tab_logic').append('<tr id="addr'+(i+1)+'"></tr>');
           
           i++; 

        
       });
     $("#delete_row").click(function(){
         if(i>1){
         $("#addr"+(i-1)).html('');
         i--;
         }
         calc();
     });
     
     $('#tab_logic tbody').on('keyup change',function(){
         calc();
     });
     $('#tax').on('keyup change',function(){
         calc_total();
     });
     
 
 });
 
 function calc()
 {
     $('#tab_logic tbody tr').each(function(i, element) {
         var html = $(this).html();
         if(html!='')
         {
             var debit = $(this).find('.debit').val();
             var credit = $(this).find('.credit').val();
             $(this).find('.total').val(debit*credit);
             $(this).find('.debit').val(debit);
             $(this).find('.credit').val(credit);
             
             calc_total();
         }
     });
 }
 
 function calc_total()
 {
     total=0;
     debit=0;
     credit=0;
     $('.total').each(function() {
         total += parseInt($(this).val());
     });
     $('.debit').each(function() {
         debit += parseInt($(this).val());
     });
     $('.credit').each(function() {
         credit += parseInt($(this).val());
     });
     $('#sub_total').val(total.toFixed(2));
     tax_sum=total/100*$('#tax').val();
     $('#tax_amount').val(tax_sum.toFixed(2));
     $('#total_amount').val((total).toFixed(2));
     $('#total_debit').val((debit).toFixed(2));
     $('#total_credit').val((credit).toFixed(2));
 }
 
 </script>
@endsection