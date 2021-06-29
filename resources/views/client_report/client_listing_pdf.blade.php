<style>

    table {
        width: 100%;
        border-collapse: collapse;
        font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
        font-size: 9px;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    .style-1 {
        color: white;
        padding-left: 10pt;
        font-size: 14pt;
        font-family: "Arial";
        font-weight: bold;
        font-style: normal;
        text-decoration: none;
        text-align: left;
        word-spacing: 0pt;
        letter-spacing: 0pt;
        white-space: pre-wrap;
        background-color: #339933;
    }
    .style-2 {
        color: black;
        padding-right: 1pt;
        font-size: 8pt;
        font-family: "Arial";
        font-weight: bold;
        font-style: normal;
        text-decoration: none;
        text-align: left;
        word-spacing: 0pt;
        letter-spacing: 0pt;
        white-space: pre-wrap;
    }
    .style-3 {
        color: black;
        padding-right: 1pt;
        font-size: 8pt;
        font-family: "Arial Narrow";
        font-weight: normal;
        font-style: normal;
        text-decoration: none;
        text-align: right;
        word-spacing: 0pt;
        letter-spacing: 0pt;
        white-space: pre-wrap;
    }
</style>
<div>

    <table class="">

            <tbody>
                    <tr style="height: 16pt">
                            <td colspan="4" valign="middle" class="style-2">{{trans_choice('general.office',1)}}</td>
                            <td valign="middle" class="style-3">
                                @if($office_id!=0)
                                    {{\App\Models\Office::find($office_id)->name}}
                                @endif
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td colspan="9" valign="middle"
                                class="style-4">{{trans_choice('general.as',1)}} {{trans_choice('general.at',1)}} {{$end_date}}</td>
                        </tr>



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