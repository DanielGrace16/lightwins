@extends('layouts.master')
@section('title')
    {{trans_choice('general.reconciliation',1)}}
@endsection
@section('content')
<style>
input {
    border: 0;
}
#table-wrapper {
  position:relative;
}
#table-scroll {
  height:150px;
  overflow:auto;  
  margin-top:0px;
}
#table-wrapper table {
  width:100%;

}
#table-wrapper table * {
  background:yellow;
  color:black;
}
#table-wrapper table thead th .text {
  position:absolute;   
  top:-20px;
  z-index:2;
  height:20px;
  width:35%;
  border:1px solid red;
}

</style>

  <div class="box box-primary">
 
        <div class="box-body hidden-print">
        <div class="body">
        <form method="post" action="{{Request::url()}}" class="form-horizontal" enctype="multipart/form-data">
                {{csrf_field()}}
                
                        <div class="demo-masked-input">
                            <div class="row clearfix">
                                <div class="col-lg-3 col-md-6"> <b>{{trans_choice('general.start',1)}} {{trans_choice('general.date',1)}}</b>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i> </span>
                                        <input type="text" name="start_date" class="form-control date-picker"
                               value="{{$start_date}}"
                               required id="start_date">
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6"> <b>{{trans_choice('general.end',1)}} {{trans_choice('general.date',1)}}</b>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>                                        
                                            <input type="text" name="end_date" class="form-control date-picker"
                               value="{{$end_date}}"
                               required id="end_date">
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6"> <b>{{trans_choice('general.office',1)}}</b>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-university"></i></span>
                                        <select name="office_id" class="form-control select2" id="office_id">
                            <option value="0"
                                    @if($office_id==0) selected @endif>{{trans_choice('general.all',1)}}</option>
                            @foreach(\App\Models\Office::all() as $key)
                                <option value="{{$key->id}}"
                                        @if($office_id==$key->id) selected @endif>{{$key->name}}</option>
                            @endforeach
                        </select>
                                    </div>
                                </div>
                                
                                
                               
                                <div class="col-lg-3 col-md-6"> <b>Closing balance(ZMK)</b>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-money"></i></span>
                                        <input type="text" value="{{$close_balance}}" class="form-control money-dollar" id="close_balanceid" name="close_balance">
                                    </div>
                                </div>                               
                                <div class="col-lg-3 col-md-6"> <b>{{trans_choice('general.account',1)}}</b>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                        <select name="gl_account_id" class="form-control select2" id="gl_account_id">
                            @foreach(\App\Models\GlAccount::all() as $key)
                                <option value="{{$key->id}}"
                                        @if($gl_account_id==$key->id) selected @endif>{{$key->name}}</option>
                            @endforeach
                        </select>
                                    </div>
                                </div>




                             
                                <div class="col-lg-3 col-md-6"> <b>Show</b>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-eye"></i></span>
                                        <select name="show" class="form-control select2" id="show">
                            <option value="0"
                                    @if($show==0) selected @endif>{{trans_choice('general.all',1)}}</option>
                            <option value="1"
                                    @if($show==1) selected @endif>{{trans_choice('general.unreconciled',1)}}</option>
                            <option value="2"
                                    @if($show==2) selected @endif>{{trans_choice('general.reconciled',1)}}</option>
                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            
             

               
    
               
                



                <div class="form-group">
                    <label for=""
                           class="control-label col-md-8"></label>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-success" id="search"><span class="fa fa-list"></span> &nbsp; List {{trans_choice('general.transaction',1)}}s
                        </button>

                        
                    </div>
                    
                </div>
            </form>

        </div>
        <!-- /.box-body -->

    </div>
    <!-- /.box -->
    @if(!empty($start_date))
        <div class="box box-white">
            <div class="box-body ">
            <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#accounts" data-toggle="tab">Reconcile Balances</a>
                    </li>
                  
                        <li><a href="#client_identification"
                               data-toggle="tab">Reconciliation Statement</a>
                        </li>
                        <li><a href="#recons"
                               data-toggle="tab">Reconciliations</a>
                        </li>
                        
                  
                </ul>
                
                <div class="tab-content">
                    <div class="active tab-pane" id="accounts">
                    <form method="post" action="{{url('accounting/reconciliation/store')}}" id="reconcile_form"
                      class="form-horizontal" enctype="multipart/form-data">
                    {{csrf_field()}}
                    
                    <div  class="table-responsive">
                   
                    <table id="data-table" class="table table-striped table-condensed table-hover">
                    <?php
                      $opening_balance = 0;
                     
                      $ocr = 0;
                      $odr = 0;
                      $b_dr = 0;
                      $b_cr = 0;
                      $total_dr = 0;
                      $total_cr = 0;
                      $op_bal_dr = 0;
                      $op_bal_cr = 0;
                      $toffice = \App\Models\Office::find($office_id);
                      $journals = \App\Models\GlJournalEntry::where('gl_account_id', $gl_account_id)->where('office_id', $office_id)->where('date','>=',$toffice->opening_date)->first();
                      $op_bal_dr = $op_bal_dr + $journals->op_balance_dr;
                      $op_bal_cr = $op_bal_cr + $journals->op_balance_cr;
                      $opening_balance = $op_bal_dr - $op_bal_cr;
                      $balancebf = $opening_balance + $current_balance;
                      
                      
                      
                    ?>
          
                    <?php
                             
                                ?>   
                            <thead>
                            <tr>
                                <th>{{trans_choice('general.reference',1)}} </th>
                                <th>{{trans_choice('general.transaction',1)}} {{trans_choice('general.type',1)}}</th>
                                <th>{{trans_choice('general.date',1)}}</th>
                                <th>{{trans_choice('general.office',1)}}</th>
                                <th>{{trans_choice('general.account',1)}}</th>
                                <th>{{trans_choice('general.debit',1)}}</th>
                                <th>{{trans_choice('general.credit',1)}}</th>
                                <th class ="hidden">{{trans_choice('general.balance',1)}}</th>
                                <th>
                           <button type="button" id="selectAll" class="close"> <span class="sub"></span> Check All</button>
                          </th>
                                
                            </tr>
                            </thead>
                            <tbody>
                            <?php
                     $total_op_dr = 0;
                     $total_op_cr = 0;
                     $op_balance_dr = 0;
                     $op_balance_cr = 0;
                     $op_balance_dr =  $op_balance_dr + $key->op_balance_dr;
                     $op_balance_cr =  $op_balance_cr + $key->op_balance_cr;
                     $total_op_dr = $total_op_dr + $op_balance_dr;
                     $total_op_cr = $total_op_cr + $op_balance_cr;
                    
                    ?>

                     <?php
                    $total_debit_balance = 0;
                    $total_credit_balance = 0;
                    $total_opening_balance = 0;
                    $total_closing_balance = 0;
                    $total_op_dr = 0;
                    $total_op_cr = 0;
                    $total_dr = 0;
                    $total_cr = 0;
                    $total_balance = 0;
                    ?>
                            @foreach($data as $key)
                            <?php
                        $op_bal_dr = 0;
                        $op_bal_cr = 0;
                        $op_bal_dr = $op_bal_dr + $key->op_balance_dr;
                        $op_bal_cr = $op_bal_cr +$key->op_balance_cr;
                        $dr = 0;
                        $cr = 0;
                        $curbalance = 0;
                        $cr = $cr + $key->credit + $key->op_balance_cr;
                        $dr = $dr + $key->debit  + $key->op_balance_r;
                        $total_op_dr = $total_op_dr + $op_bal_dr;
                        $total_op_cr = $total_op_cr + $op_bal_cr;
                        $total_dr = $total_dr + $dr;
                        $total_cr = $total_cr + $cr;
                        if ($key->account_type == "asset" || $key->account_type == "expense") {
                            //debit balance
                            $curbalance = $dr - $cr;
                            
                        }
                        if ($key->account_type == "liability" || $key->account_type == "equity" || $key->account_type == "income") {
                            //debit balance
                            $curbalance = $cr - $dr;
                            
                        }
                        $total_balance = $total_balance + $curbalance;
                        ?>
                                      <?php
                                     
      
                                      $prev_balance = 0;
                                      $prev_balance = $total_op_dr - $total_op_cr;
                                      $closing_balance = 0;
                                      $closing_balance = $prev_balance + $total_dr - $total_cr;
                                      $prev_balance = $closing_balance;
                                      $debits=0;
                                      $credits=0;
      
                                      $fdebit = $op_balance_dr + $dr;
                                      $fcredit = $op_balance_cr + $cr;
      
          
                              if($fdebit>$fcredit)
                              {
                                  $debits = $prev_balance - $debits;
                                  $credits = "";
                              }else{
          
                                  $credits = $prev_balance - $credits;
                                  $debits = "";
                              }
                                          
                                      ?>
                                <tr>
                                <?php
                              $income = \App\Models\OtherIncome::where('id', $key->reference)->get();  
                              $expense = \App\Models\Expense::where('id', $key->reference)->get();  
                                  ?>
                                    
                                    <td>   @if($key->name=='income')
                                       
                                       @endif
                                       @if(!empty($key->payment_detail)) 
                                       {{ $key->payment_detail->notes }}
                                       @endif    
                                       @if(!empty($key->loan))
                                       @if($key->loan->client_type=="client")
                                       @if(!empty($key->loan->client))
                                           @if($key->loan->client->client_type=="individual")
                                               {{$key->loan->client->first_name}} {{$key->loan->client->middle_name}} {{$key->loan->client->last_name}}
                                           @endif
                                           @if($key->loan->client->client_type=="business")
                                               {{$key->loan->client->full_name}}
                                           @endif
                                       @endif
                                   @endif
                                   @if($key->loan->client_type=="group")
                                       @if(!empty($key->loan->group))
                                           {{$key->loan->group->name}}
                                       @endif
                                   @endif
                                  
                               @endif
                           @foreach($income as $inkey)
                               @if($key->name=='Other income')
                               {{$inkey->name}}
                             @endif
                              @endforeach
                       @foreach($expense as $exkey)
                               @if($key->transaction_type=='expense')
                               {{$exkey->name}}
                                   @endif
                              @endforeach</td>
                                    <td>
                                        @if($key->transaction_type=='disbursement')
                                            {{trans_choice('general.disbursement',1)}}
                                        @endif
                                        @if($key->transaction_type=='accrual')
                                            {{trans_choice('general.accrual',1)}}
                                        @endif
                                        @if($key->transaction_type=='deposit')
                                            {{trans_choice('general.deposit',1)}}
                                        @endif
                                        @if($key->transaction_type=='withdrawal')
                                            {{trans_choice('general.withdrawal',1)}}
                                        @endif
                                        @if($key->transaction_type=='manual_entry')
                                            {{trans_choice('general.manual_entry',2)}}
                                        @endif
                                        @if($key->transaction_type=='pay_charge')
                                            {{trans_choice('general.pay',1)}}    {{trans_choice('general.charge',1)}}
                                        @endif
                                        @if($key->transaction_type=='transfer_fund')
                                            {{trans_choice('general.transfer_fund',1)}} {{trans_choice('general.charge',2)}}
                                        @endif
                                        @if($key->transaction_type=='expense')
                                            {{trans_choice('general.expense',1)}}
                                        @endif
                                        @if($key->transaction_type=='payroll')
                                            {{trans_choice('general.payroll',1)}}
                                        @endif
                                        @if($key->transaction_type=='income')
                                            {{trans_choice('general.income',1)}}
                                        @endif
                                        @if($key->transaction_type=='penalty')
                                            {{trans_choice('general.penalty',1)}}
                                        @endif
                                        @if($key->transaction_type=='fee')
                                            {{trans_choice('general.fee',1)}}
                                        @endif
                                        @if($key->transaction_type=='close_write_off')
                                            {{trans_choice('general.write',1)}}  {{trans_choice('general.waiver',2)}}
                                        @endif
                                        @if($key->transaction_type=='repayment_recovery')
                                            {{trans_choice('general.repayment',1)}}
                                        @endif
                                        @if($key->transaction_type=='repayment')
                                            {{trans_choice('general.repayment',1)}}
                                        @endif
                                        @if($key->transaction_type=='interest_accrual')
                                            {{trans_choice('general.interest',1)}} {{trans_choice('general.accrual',1)}}
                                        @endif
                                        @if($key->transaction_type=='fee_accrual')
                                            {{trans_choice('general.fee',1)}} {{trans_choice('general.accrual',1)}}
                                        @endif
                                    </td>
                                    <td>{{ $key->date }}</td>
                                    <td>
                                        @if(!empty($key->office))
                                            {{ $key->office->name }}
                                        @endif
                                    </td>
                                    <td>
                                        @if(!empty($key->gl_account))
                                            {{ $key->gl_account->name }}
                                        @endif
                                    </td>
                                                                        
                                    <td>{{ number_format($key->debit,2) }}</td>
                                    <td>{{ number_format($key->credit,2)}}</td>
                                    <?php
                                      $balance = 0;
                                      $balance = $balance + $key->debit - $key->credit;  
                                        
                                        
                                        ?>
                                    <td class="AmountLoaned">  <p class ="hidden">{{$balance}}</p>  </td>
                                    
                                    <td>
                                        @if($key->reconciled==1)
                                            <span class="label label-success">{{trans_choice('general.reconciled',1)}}</span>
                                        @else
                                            <label>
                                                <input type="checkbox" class="reconcile_checkbox" name="reconcile_ids[]"
                                                       value="{{$key->id}}"
                                                       id="reconcile_{{$key->id}}">
                                            </label>
                                           
                                        @endif
                                    </td>
                                    
                                </tr>
                            @endforeach
                            </tbody>
                           
                        </table>
                        
                    </div>
                    <div class="box-footer">
                    <hr>
                    <div class="form-group no-margin">
                    <div class="col-md-2">
                    <button type="submit" class="btn btn-default button-submit" name="action"  value="save"
                                 data-dismiss="modal" aria-label="Close"><span class="fa fa-save"></span>  Save
                        </button><br> 
                        </div>
                        <div class="col-md-8">
                        <button type="submit" name="action"  value="reconcile" class="btn btn-success"
                                id="save_reconcile">Reconcile
                        </button><br> 
                        </div>
                     </div>
                     </div>
                        <table class="table">
                            <tbody>
                            <?php

                           $cbbalance = 0;
                           $cbcr = 0; 
                           $cbdr = 0;
                           $reconciled_cleared_balance = 0;
                           $total_cbcr = 0;
                           $total_cbdr = 0;
                            $cbjournals = \App\Models\GlJournalEntry::where('gl_account_id', $key->gl_account_id)->where('reconciled', 1)->where('reversed', 0)->when($office_id, function ($query) use ($office_id) {
                                if ($office_id != 0) {
                                    $query->where('office_id', '=', $office_id);
                                }
                            })->whereBetween('date',
                            [$start_date, $end_date])->get();
                            
                            foreach ($cbjournals as $keyjournal) {
                                $cbcr = $cbcr + $keyjournal->credit;
                                $cbdr = $cbdr + $keyjournal->debit;
                            }
                            $cbbalance = $cbcr - $cbdr;
                            $total_cbcr = $total_cbcr + $cbcr;
                            $total_cbdr = $total_cbdr + $cbdr;
                            $reconciled_cleared_balance = $balancebf + $total_cbdr - $total_cbcr;



                            
                            ?>
                                <tr>
                                    <th class="text-right">Brought forward {{trans_choice('general.balance',1)}}:</th>
                                    <td id="closing-balance" class="col-md-1 text-right">  <strong>ZMK</strong></span><input {font-weight:bold;} type="text" id="recon_ba" value="{{$reconciled_cleared_balance}}" readonly="readonly"></div> </td>
                                </tr>
                                <tr>
                                    <th class="text-right">{{trans_choice('general.closing',1)}} {{trans_choice('general.balance',1)}}:</th>
                                    <td id="closing-balance" class="col-md-1 text-right">  <strong>ZMK</strong></span><input {font-weight:bold;} type="text" id="close_ba" value="{{$close_balance}}" readonly="readonly"></div> </td>
                                </tr>
                                <tr class = "hidden">
                                    <th class="text-right"> Cleared {{trans_choice('general.balance',1)}}:</th>
                                    <?php
                                    $curr_balance = 0;
                                  
                                    $curr_balance = $curr_balance + $close_balance - $balance;
                                  

                                    
                                    ?>
                                    <td  id="closing-balance" class="col-md-1 text-right">  <strong>ZMK</strong></span><input type="text" id="TotalInvoiceAmt" value="" readonly="readonly"></div> </td>
                                </tr>


                                <tr>
                                    <th class="text-right"> Cleared  {{trans_choice('general.balance',1)}}:</th>
                                    <?php
                                    $curr_balance = 0;
                                  
                                    $curr_balance = $curr_balance + $close_balance - $balance;
                                  

                                    
                                    ?>
                                    <td  id="closing-balance" class="col-md-1 text-right">  <strong>ZMK</strong></span><input type="text" id="cfinal" value="" readonly="readonly"></div> </td>
                                </tr>
                                <tr class="hidden">
                                    <th class="text-right">Difference:</th>
                                    <?php
                                   
                                    $diff = 0;
                                   
                                    $diff =  $close_balance - $curr_balance;

                                    
                                    ?>
                                    <td id="closing-balance" class="col-md-1 text-right">  <strong>ZMK</strong></span><input type="text" id="su" value="{{$diff}}" readonly="readonly"></div> </td>
                                </tr>
                            </tbody>
                        </table>
                        
                </form>
               
                    </div>
                    @if (Sentinel::hasAccess('clients.identification.view'))
                    <div class="tab-pane" id="recons">
                    <div class="box-body">
        <div class="table table-responsive">
           
        </div>
    </div>

                     </div>
                    @endif
                  








                    @if (Sentinel::hasAccess('clients.identification.view'))
                        <div class="tab-pane" id="client_identification">
                            <div class="row">
                                <div class="col-md-12">
                                   
                                </div>
                                <div class="col-md-12 table-responsive">
                                <div class="invoice p-3 mb-3">
              <!-- title row -->
              <div class="row">
                <div class="col-12">
                <h4 class="text-center">
        @if(!empty(\App\Models\Setting::where('setting_key','company_logo')->first()->setting_value))
            <img src="{{ asset('uploads/'.\App\Models\Setting::where('setting_key','company_logo')->first()->setting_value) }}"
                 class="img-responsive" width="150"/>

        @endif
    </h4>
                </div>
                <!-- /.col -->
              </div><br>
              <!-- info row -->
              <div class="row invoice-info">
                <div class="col-sm-4 invoice-col">
                  
                  <address>
                    <strong>{{ $key->office->name }}</strong><br>
                     {{ $key->gl_account->name }}
                  </address>
                </div>
                <!-- /.col -->
          
                <!-- /.col -->
                <div class="col-sm-6 invoice-col">
                  <h3><b> Bank Reconciliation statement as at  {{$end_date}}</b></h3>
                  
                  <br>
                 
                </div>
               
                <!-- /.col -->
              </div>
              <!-- /.row -->

              <!-- Table row -->
              <div class="row">
                <div class="col-12 table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                      <th>Bank Statement Closing Balance</th>
                      <th></th>
                      <th></th>
                      <th></th>
                     
                      <th> <b>{{number_format($close_balance,2)}}</b></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                      
                    </tr>
                    <tr>
                      
                    </tr>
                    <tr>
                      
                    </tr>
                    <tr>
                     
                    </tr>
                    </tbody>
                  </table>

                  <div class="card-header">
                  <span><h5> Add   : <strong>Deposits and Other Credits in Transit </strong></h5></span>
                  </div>
                   <hr>
                  
                  
                  <table class="table table-striped">
                    <thead>
                    <tr>
                      <th>Date</th>
                      <th >Reference</th>
                      <th class ="hidden">Serial #</th>
                      <th class ="hidden">Description</th>
                      <th class ="hidden">Subtotal</th>
                    </tr>
                   
                    </thead>
                   
                    <tbody>
                   
                    <?php
                        $balance = 0;
                        $dr = 0;
                        $cr = 0;
                        $journals = \App\Models\GlJournalEntry::where('gl_account_id', $gl_account_id)->where('reconciled','=', 0)->where('reversed','=', 0)->where('credit','>', 0)->when($office_id, function ($query) use ($office_id) {
                            if ($office_id != 0) {
                                $query->where('office_id', '=', $office_id);
                            }
                        })->where('date', '<=', $end_date)->orderBy('date', 'asc')->get();

                        foreach ($journals as $journal) {
                            $cr = $cr + $journal->op_balance_cr;
                            $dr = $dr + $journal->op_balance_dr;
                        }
                        $balance = $cr - $dr;
                       
                        ?>

<?php

$total_udr = 0;
$total_ucr = 0;
$total_balance = 0;
?>

                         
                            @foreach($journals as $jkey)
                            <?php
                            $ucr = 0;
                            $dr = 0;
 $ucr = $ucr + $jkey->credit + $key->op_balance_cr;
 $dr = $dr + $jkey->debit  + $key->op_balance_r;
 $total_ucr = $total_ucr + $ucr;


?>
                                <tr>
                                    <td>{{ $jkey->date }}</td>
                                    <td>   @if($jkey=='income')
                                       
                                       @endif
                                       @if(!empty($jkey->payment_detail)) 
                                       {{ $jkey->payment_detail->notes }}
                                       @endif    
                                       @if(!empty($jkey->loan))
                                       @if($jkey->loan->client_type=="client")
                                       @if(!empty($jkey->loan->client))
                                           @if($jkey->loan->client->client_type=="individual")
                                               {{$jkey->loan->client->first_name}} {{$jkey->loan->client->middle_name}} {{$jkey->loan->client->last_name}}
                                           @endif
                                           @if($jkey->loan->client->client_type=="business")
                                               {{$jkey->loan->client->full_name}}
                                           @endif
                                       @endif
                                   @endif
                                   @if($jkey->loan->client_type=="group")
                                       @if(!empty($jkey->loan->group))
                                           {{$jkey->loan->group->name}}
                                       @endif
                                   @endif
                                  
                               @endif
                           @foreach($income as $inkey)
                               @if($key->name=='Other income')
                               {{$inkey->name}}
                             @endif
                              @endforeach
                       @foreach($expense as $exkey)
                               @if($jkey->transaction_type=='expense')
                               {{$exkey->name}}
                                   @endif
                              @endforeach</td>
                              <td>
                                        @if($jkey->transaction_type=='disbursement')
                                            {{trans_choice('general.disbursement',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='accrual')
                                            {{trans_choice('general.accrual',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='deposit')
                                            {{trans_choice('general.deposit',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='withdrawal')
                                            {{trans_choice('general.withdrawal',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='manual_entry')
                                            {{trans_choice('general.manual_entry',2)}}
                                        @endif
                                        @if($jkey->transaction_type=='pay_charge')
                                            {{trans_choice('general.pay',1)}}    {{trans_choice('general.charge',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='transfer_fund')
                                            {{trans_choice('general.transfer_fund',1)}} {{trans_choice('general.charge',2)}}
                                        @endif
                                        @if($jkey->transaction_type=='expense')
                                            {{trans_choice('general.expense',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='payroll')
                                            {{trans_choice('general.payroll',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='income')
                                            {{trans_choice('general.income',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='penalty')
                                            {{trans_choice('general.penalty',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='fee')
                                            {{trans_choice('general.fee',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='close_write_off')
                                            {{trans_choice('general.write',1)}}  {{trans_choice('general.waiver',2)}}
                                        @endif
                                        @if($jkey->transaction_type=='repayment_recovery')
                                            {{trans_choice('general.repayment',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='repayment')
                                            {{trans_choice('general.repayment',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='interest_accrual')
                                            {{trans_choice('general.interest',1)}} {{trans_choice('general.accrual',1)}}
                                        @endif
                                        @if($jkey->transaction_type=='fee_accrual')
                                            {{trans_choice('general.fee',1)}} {{trans_choice('general.accrual',1)}}
                                        @endif
                                    </td>
                                    <td></td>
                                    <td>
                                       
                                    </td>
                                    <td>
                                        
                                    </td>
                                                                        
                                   
                                    <td>{{ number_format($jkey->credit,2) }}</td>
                                    <?php
                                      $balance = 0;
                                      $balance = $balance + $jkey->debit + $jkey->credit;  
                                      
                                        
                                        ?>
                                   
                                    
                                </tr>
                            @endforeach
                          
                            </tbody>
                            <tr>
                            <td><b>#</b></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b>{{number_format($total_ucr,2)}}</b></td>
                            </tr>
                  </table>
                  



                  <h5> Less  : <strong>Outstanding Cheques and Other Debits </strong></h5>
                   <hr>

                  
                   <table class="table table-striped">
                    <thead>
                    <tr>
                      <th>Date</th>
                      <th >Reference</th>
                      <th class ="hidden">Serial #</th>
                      <th class ="hidden">Description</th>
                      <th class ="hidden">Subtotal</th>
                    </tr>
                   
                    </thead>
                   
                    <tbody>
                   
                    <?php
                        $balance = 0;
                        $dr = 0;
                        $cr = 0;
                        $journals = \App\Models\GlJournalEntry::where('gl_account_id', $key->gl_account_id)->where('reconciled', 0)->where('reversed', 0)->where('debit','>', 0)->when($office_id, function ($query) use ($office_id) {
                            if ($office_id != 0) {
                                $query->where('office_id', '=', $office_id);
                            }
                        })->where('date', '<=', $end_date)->orderBy('date', 'asc')->get();

                        foreach ($journals as $journal) {
                            $cr = $cr + $journal->op_balance_cr;
                            $dr = $dr + $journal->op_balance_dr;
                        }
                        $balance = $cr - $dr;
                       
                        ?>
                        <?php

                        $total_udr = 0;
                        
                        $total_balance = 0;
                        ?>
                            @foreach($journals as $dkey)
                            <?php
                            $ucr = 0;
                            $dr = 0;
 $ucr = $ucr + $dkey->credit + $dkey->op_balance_cr;
 $udr = $dr + $dkey->debit  + $dkey->op_balance_r;
 $total_udr = $total_udr + $udr;


?>
                                <tr>
                                    <td>{{ $dkey->date }}</td>
                                    <td>   
                                    @if($dkey->name=='income')
                                       
                                       @endif
                                       @if(!empty($dkey->payment_detail)) 
                                       {{ $dkey->payment_detail->notes }}
                                       @endif    
                                       @if(!empty($dkey->loan))
                                       @if($dkey->loan->client_type=="client")
                                       @if(!empty($dkey->loan->client))
                                           @if($dkey->loan->client->client_type=="individual")
                                               {{$dkey->loan->client->first_name}} {{$dkey->loan->client->middle_name}} {{$dkey->loan->client->last_name}}
                                           @endif
                                           @if($dkey->loan->client->client_type=="business")
                                               {{$dkey->loan->client->full_name}}
                                           @endif
                                       @endif
                                   @endif
                                   @if($dkey->loan->client_type=="group")
                                       @if(!empty($dkey->loan->group))
                                           {{$dkey->loan->group->name}}
                                       @endif
                                   @endif
                                  
                               @endif
                           @foreach($income as $inkey)
                               @if($dkey->name=='Other income')
                               {{$inkey->name}}
                             @endif
                              @endforeach
                           @foreach($expense as $exkey)
                               @if($dkey->transaction_type=='expense')
                               {{$exkey->name}}
                                   @endif
                              @endforeach</td>
                                    <td>
                                    @if($dkey->transaction_type=='disbursement')
                                            {{trans_choice('general.disbursement',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='accrual')
                                            {{trans_choice('general.accrual',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='deposit')
                                            {{trans_choice('general.deposit',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='withdrawal')
                                            {{trans_choice('general.withdrawal',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='manual_entry')
                                            {{trans_choice('general.manual_entry',2)}}
                                        @endif
                                        @if($dkey->transaction_type=='pay_charge')
                                            {{trans_choice('general.pay',1)}}    {{trans_choice('general.charge',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='transfer_fund')
                                            {{trans_choice('general.transfer_fund',1)}} {{trans_choice('general.charge',2)}}
                                        @endif
                                        @if($dkey->transaction_type=='expense')
                                            {{trans_choice('general.expense',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='payroll')
                                            {{trans_choice('general.payroll',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='income')
                                            {{trans_choice('general.income',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='penalty')
                                            {{trans_choice('general.penalty',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='fee')
                                            {{trans_choice('general.fee',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='close_write_off')
                                            {{trans_choice('general.write',1)}}  {{trans_choice('general.waiver',2)}}
                                        @endif
                                        @if($dkey->transaction_type=='repayment_recovery')
                                            {{trans_choice('general.repayment',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='repayment')
                                            {{trans_choice('general.repayment',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='interest_accrual')
                                            {{trans_choice('general.interest',1)}} {{trans_choice('general.accrual',1)}}
                                        @endif
                                        @if($dkey->transaction_type=='fee_accrual')
                                            {{trans_choice('general.fee',1)}} {{trans_choice('general.accrual',1)}}
                                        @endif


                                    </td>
                                    <td>
                                       
                                    </td>
                                    <td>
                                        
                                    </td>
                                    <td>{{ number_format($dkey->debit,2) }}</td>
                                                             
                                    
                                   
                                    <?php
                                      $xbalance = 0;
                                      $xbalance = $balance + $dkey->debit + $dkey->credit;  
                                        
                                        
                                        ?>
                                   
                                    
                                </tr>
                            @endforeach
                          
                            </tbody>
                            <tr>
                            <td><b>#</b></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b>{{number_format($total_udr,2)}}</b></td>
                            </tr>
                  </table>
                  
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->

              <div class="row">
                <!-- accepted payments column -->
                <div class="col-6">
                  
               
                <!-- /.col -->
                <div class="col-6">
                 
                  <div class="table-responsive">
                    <table class="table">
                 
                      <tr>

                      <?php
                        $rtbalance = 0;
                        $rtdr = 0;
                        $rtcr = 0;
                        $rjournals = \App\Models\GlJournalEntry::where('gl_account_id', $gl_account_id)->where('reversed','=', 0)->when($office_id, function ($query) use ($office_id) {
                            if ($office_id != 0) {
                                $query->where('office_id', '=', $office_id);
                            }
                        })->whereBetween('date',
                        [$start_date, $end_date])->orderBy('date', 'asc')->get();

                        foreach ($rjournals as $rtjournal) {
                            $rtcr = $rtcr + $rtjournal->credit;
                            $rtdr = $rtdr + $rtjournal->debit;
                        }
                        $rtbalance = $rtcr - $rtdr;
                       
                        ?>

<?php

$total_rdr = 0;
$total_rcr = 0;
$total_balance = 0;
?>

                      <?php
                      $total_rdr = $total_rdr + $rtdr;
                      $total_rcr = $total_rcr + $rtcr;
                       $cashbook = $balancebf + $total_rdr - $total_rcr;
                      
                      ?>
                        <th style="width:50%">Cashbook balance:</th>
                        <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        <td>{{number_format($cashbook,2)}}</td>
                      </tr>
                      <tr>
                        <th><i>plus/minus<i> <b>Adjustments</b></th>
                        <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        <td>0.00</td>
                      </tr>
                      <tr>

                      <?php
                        $rcbalance = 0;
                        $total_rccr = 0;
                        $total_rcdr = 0;
                        $rcdr = 0;
                        $rccr = 0;
                        $rcjournals = \App\Models\GlJournalEntry::where('gl_account_id', $key->gl_account_id)->where('reconciled', 1)->where('reversed', 0)->when($office_id, function ($query) use ($office_id) {
                            if ($office_id != 0) {
                                $query->where('office_id', '=', $office_id);
                            }
                        })->whereBetween('date',
                        [$start_date, $end_date])->get();

                        foreach ($rcjournals as $rjournal) {
                            $rccr = $rccr + $rjournal->credit;
                            $rcdr = $rcdr + $rjournal->debit;
                        }
                        $rcbalance = $rcdr - $rccr;
                        $total_rccr = $total_rccr + $rccr;
                        $total_rcdr = $total_rcdr + $rcdr;
                        $reconciled_cashbook_balance = $balancebf + $total_rcdr - $total_rccr;
                        ?>


                        <th>Reconciled Cashbook Balance</th>
                        <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        <td>{{number_format($reconciled_cashbook_balance,2)}}</td>
                      </tr>
                      <tr>
                        <th>Unreconciled Balance</th>
                        <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        <td>0.00</td>
                      </tr>
                    
                    </table>
                  </div>
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->

              <!-- this row will not appear when printing -->
              <div class="row no-print">
                <div class="col-12">
                 
                </div>
              </div>
            </div>
            <!-- /.invoice -->
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
                                </div>
                            </div>
                        </div>
                        
                    @endif
                
            </div>
            <!-- /.box-body -->
         
            </div>

        </div>
        
    @endif
    
    @endsection
    
    @section('footer-scripts')
 
     <script>
     $('#data-table').DataTable({
        "search": "{{ trans('general.search') }}",
        "bJQueryUI":true,
        "bSort":false,
        "bPaginate":false, // Pagination True 
        "sPaginationType":"full_numbers", // And its type.
        "iDisplayLength": 10
        });  
    </script>
    <script src="{{ asset('assets/plugins/almasaeed2010/adminlte/plugins/datepicker/locales/bootstrap-datepicker.js') }}"></script>
    
    
    
    <script> 

$(document).ready(function () {
  $('body').on('click', '#selectAll', function () {
    if ($(this).hasClass('allChecked')) {
        $('input[type="checkbox"]', '#data-table').prop('checked', false);
    } else {
        $('input[type="checkbox"]', '#data-table').prop('checked', true);
    }
    calculateInvoiceTotals();
    calculateTransferTotals();
    
   
    $("#cfinal").val(Number($("#TotalInvoiceAmt").val()) + Number($("#recon_ba").val()));
    $("#su").val(Number($("#close_balanceid").val()) - Number($("#cfinal").val()));
    $(this).toggleClass('allChecked');
  })
});
</script>
<script>
     $('#start_date').datepicker({
                format: 'yyyy-mm-dd',
                todayBtn: 'linked',
                weekStart: 1,
                autoclose: true,
                
            });

            $('#end_date').datepicker({
                format: 'yyyy-mm-dd',
                todayBtn: 'linked',
                weekStart: 1,
                autoclose: true,
               
            });
        
        $("#save_reconcile").click(function (e) {
            e.preventDefault();
            swal({
                title: 'Are you sure?',
                text: 'This will save all marked transactions as reconciled',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Ok',
                cancelButtonText: 'Cancel'
            }).then(function () {
                $("#reconcile_form").submit();
            })
        })
        
    </script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


    <script>

    $('.reconcile_checkbox').change(function () {
    calculateInvoiceTotals();
    calculateTransferTotals();
    
   
    $("#cfinal").val(Number($("#TotalInvoiceAmt").val()) + Number($("#recon_ba").val()));
    $("#su").val(Number($("#close_balanceid").val()) - Number($("#cfinal").val()));
    
   
  }).change();


// Calculate the total invoice amount from selected items only
function calculateInvoiceTotals() {
    var Sum = 0;
    // iterate through each td based on class and add the values
    $(".AmountLoaned").each(function () {
        //Check if the checkbox is checked
        if ($(this).closest('tr').find('.reconcile_checkbox').is(':checked')) {
            var value = $(this).text();
            // add only if the value is number
            if (!isNaN(value) && value.length != 0) {
                Sum += parseFloat(value);
            }
        }
    });
    $('#TotalInvoiceAmt').val(Sum.toFixed(2));
};
// Calculate the total transfer amount from selected items only
function calculateTransferTotals() {
    var Sum = 0;
    $(".TransferAmount").each(function () {
        //Check if the checkbox is checked
        if ($(this).closest('tr').find('.reconcile_checkbox').is(':checked')) {
            
            var value = $('p', this).text();
            // add only if the value is number
            if (!isNaN(value) && value.length != 0) {
                Sum += parseFloat(value);
            }
        }
    });
    $('#TotalTransferAmt').text(Sum.toFixed(2));
};
    
   

</script>


@endsection
