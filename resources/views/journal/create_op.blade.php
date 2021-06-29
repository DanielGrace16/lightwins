@extends('layouts.master')
@section('title'){{trans_choice('general.opening',1)}}  {{trans_choice('general.balance',1)}}
@endsection
@section('content')
    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">{{ trans_choice('general.opening',1) }} {{ trans_choice('general.balance',1) }}</h3>
                                        </div>
                        <form method="post" action="{{url('accounting/journal/store_op')}}" class="form-horizontal"
                              enctype="multipart/form-data">
                            {{csrf_field()}}
                            <div class="box-body">
                
                       
                                <div class="form-group">
                                    <label for=""
                                           class="control-label col-md-2">{{trans_choice('general.opening',1)}} {{trans_choice('general.balance',1)}}</label>
                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-primary" data-toggle="collapse"
                                                data-target="#show_payment_details">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div id="show_payment_details" class="collapse">
                                        <div class="form-group">
                                                <label for="office_id"
                                                       class="control-label col-md-2">{{trans_choice('general.office',1)}}</label>
                                                <div class="col-md-3">
                                                    <select name="office_id" class="form-control select2" id="office_id">
                                                        <option></option>
                                                        @foreach(\App\Models\Office::all() as $key)
                                                            <option value="{{$key->id}}">{{$key->name}}</option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                                <label for="amount"
                                                       class="control-label col-md-2">{{trans_choice('general.amount',1)}}</label>
                                                <div class="col-md-3">
                                                    <input type="text" name="amount" class="form-control"
                                                           value="{{old('amount')}}"
                                                           required id="">
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label for="debit"
                                                       class="control-label col-md-2">{{trans_choice('general.debit',1)}}</label>
                                                <div class="col-md-3">
                                                    <select name="op_debit" class="form-control select2" id="op_debit">
                                                        <option></option>
                                                        @foreach(\App\Models\GlAccount::all() as $key)
                                                            <option value="{{$key->id}}">{{$key->name}}</option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                                <label for="credit"
                                                       class="control-label col-md-2">{{trans_choice('general.credit',1)}}</label>
                                                <div class="col-md-3">
                                                    <select name="op_credit" class="form-control select2" id="op_credit">
                                                        <option></option>
                                                        @foreach(\App\Models\GlAccount::all() as $key)
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
    

                <?php

                ?>
                
                       

                </div>

            </div>
            <!-- /.box-body -->
            <div class="box-footer">
                <div class="heading-elements">
                    <button type="submit" class="btn btn-primary pull-right">{{trans_choice('general.submit',1)}}</button>
                </div>
            </div>
        </form>
    </div>
    <!-- /.box -->
@endsection
@section('footer-scripts')
    <script>
        $(".form-horizontal").validate({
            rules: {
                field: {
                    required: true,
                    step: 10
                }
            }, highlight: function (element) {
                $(element).closest('.form-group div').addClass('has-error');
            },
            unhighlight: function (element) {
                $(element).closest('.form-group div').removeClass('has-error');
            },
            errorElement: 'span',
            errorClass: 'help-block',
            errorPlacement: function (error, element) {
                if (element.parent('.input-group').length) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });
    </script>
@endsection

