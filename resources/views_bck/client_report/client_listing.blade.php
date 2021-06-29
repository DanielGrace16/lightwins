@extends('layouts.master')
@section('title')
    {{trans_choice('general.client',1)}} {{trans_choice('general.report',1)}}
@endsection
@section('content')
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">
                {{trans_choice('general.client',1)}} {{trans_choice('general.report',1)}}
                @if(!empty($end_date))
                    as at: <b> {{$end_date}}</b>
                @endif
            </h3>

            <div class="box-tools pull-right">

            </div>
        </div>
        <div class="box-body hidden-print">
            <form method="post" action="{{Request::url()}}" class="form-horizontal" enctype="multipart/form-data">
                {{csrf_field()}}
                <div class="form-group">
                    <label for="end_date"
                           class="control-label col-md-2">{{trans_choice('general.end',1)}} {{trans_choice('general.date',1)}}</label>
                    <div class="col-md-3">
                        <input type="text" name="end_date" class="form-control date-picker"
                               value="{{$end_date}}"
                               required id="end_date">
                    </div>
                </div>
                <div class="form-group">
                    <label for="office_id"
                           class="control-label col-md-2">{{trans_choice('general.office',1)}}</label>
                    <div class="col-md-3">
                        <select name="office_id" class="form-control select2" id="office_id" required>
                            <option value="0"
                                    @if($office_id=="0") selected @endif>{{trans_choice('general.all',1)}}</option>
                            @foreach(\App\Models\Office::all() as $key)
                                <option value="{{$key->id}}"
                                        @if($office_id==$key->id) selected @endif>{{$key->name}}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for=""
                           class="control-label col-md-2"></label>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-success">{{trans_choice('general.search',1)}}!
                        </button>

                        <a href="{{Request::url()}}"
                           class="btn btn-danger">{{trans_choice('general.reset',1)}}!</a>

                        <div class="btn-group">
                            <button type="button" class="btn bg-blue dropdown-toggle legitRipple"
                                    data-toggle="dropdown">{{trans_choice('general.download',1)}} {{trans_choice('general.report',1)}}
                                <span class="caret"></span></button>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li>
                                    <a href="{{url('report/client_report/client_listing/pdf?end_date='.$end_date.'&office_id='.$office_id)}}"
                                       target="_blank"><i
                                                class="icon-file-pdf"></i> {{trans_choice('general.download',1)}} {{trans_choice('general.to',1)}} {{trans_choice('general.pdf',1)}}
                                    </a></li>
                                <li>
                                    <a href="{{url('report/loan_report/arrears_report/excel?end_date='.$end_date.'&office_id='.$office_id)}}"
                                       target="_blank"><i
                                                class="icon-file-excel"></i> {{trans_choice('general.download',1)}} {{trans_choice('general.to',1)}} {{trans_choice('general.excel',1)}}
                                    </a></li>
                                <li>
                                    <a href="{{url('report/loan_report/arrears_report/csv?end_date='.$end_date.'&office_id='.$office_id)}}"
                                       target="_blank"><i
                                                class="icon-download"></i> {{trans_choice('general.download',1)}} {{trans_choice('general.to',1)}} {{trans_choice('general.csv',1)}}
                                    </a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </form>

        </div>

    </div>
    <!-- /.box -->
    @if(!empty($end_date))
        <div class="box box-primary">
            <div class="panel-body table-responsive ">

                <table class="table table-condensed table-hover " style="font-size: 12px">
                    <tbody>
                    <tr style="height: 25pt">
                        <td colspan="19" valign="middle"
                            class="style-1"> {{trans_choice('general.client',1)}}  {{trans_choice('general.report',1)}}</td>
                    </tr>
                    <tr style="height: 15pt">
                        <td valign="middle" class="style-2">{{trans_choice('general.date',1)}} :</td>
                        <td valign="middle" class="style-3">{{$end_date}}</td>
                        <td colspan="2" valign="middle"
                            class="style-4">{{trans_choice('general.report',1)}} {{trans_choice('general.run',1)}} {{trans_choice('general.date',1)}}
                            :
                        </td>
                        <td colspan="3" valign="middle" class="style-5"> {{date("Y-m-d H:i:s")}}</td>
                        <td colspan="12"></td>
                    </tr>
                    <tr class="">
                        <th>{{trans_choice('general.loan',1)}} {{trans_choice('general.officer',1)}}</th>
                        <th>{{trans_choice('general.office',1)}}</th>
                        <th>{{trans_choice('general.account_no',1)}}</th>
                        <th>{{trans_choice('general.client',1)}}</th>
                        <th>{{trans_choice('general.phone',1)}}</th>
                        
                      </tr>


                    
                    @foreach($data as $key)
                     
                            <tr>
                                <td>
                                    @if(!empty($key->staff))
                                        {{$key->staff->first_name}} {{$key->staff->last_name}}
                                    @endif
                                </td>
                                <td>
                                    @if(!empty($key->office))
                                        {{$key->office->name}}
                                    @endif
                                </td>
                                <td>
                                    {{ $key->account_no }}
                                </td>

                                <td>
                                    @if($key->client_type=="individual")
                                    {{ $key->first_name }}   {{ $key->middle_name }}   {{ $key->last_name }}
                                @else
                                    {{ $key->full_name }}
                                @endif
                                </td>
                                <td>
                                    {{ $key->mobile }}
                                </td>
                              
                            </tr>
                       
                    @endforeach
                    </tbody>
                   
                </table>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $("body").addClass('sidebar-xs sidebar-collapse');
            });
        </script>
    @endif
@endsection
@section('footer-scripts')

@endsection
