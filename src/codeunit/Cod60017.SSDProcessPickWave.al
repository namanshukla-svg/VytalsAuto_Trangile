codeunit 60017 "SSD Process Pick Wave"
{
    procedure SyncPickWave(SSDDockPlanning: Record "SSD Dock Planning"; var APIStatus: Boolean; var ErrorText: Text)
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        AccessToken: Text;
        RequestBody: Text;
        ResponseText: Text;
    begin
        WarehouseSetup.Get();
        if WarehouseSetup."SSD Internal Instance" then begin
            APIStatus:=true;
            exit;
        end;
        SSDDockPlanning.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(SSDDockPlanning."Location Code")then exit;
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Pick Wave URL");
        AccessToken:=SSDAutomationSyncMgt.GetAccessToken();
        RequestBody:=CreatePickWaveJson(SSDDockPlanning);
        if SSDAutomationSetup."Show Json" then Message(RequestBody);
        ResponseText:=SSDAutomationSyncMgt.PostAnzo(SSDAutomationSetup."Anzo Pick Wave URL", RequestBody, AccessToken);
        JsonToken.ReadFrom(ResponseText);
        Clear(JsonObject);
        JsonObject:=JsonToken.AsObject();
        ResponseText:=GetJsonToken(JsonObject, 'status').AsValue().AsText();
        if ResponseText = 'Success' then begin
            APIStatus:=true;
            ErrorText:='';
        end
        else
            Error(ResponseText);
    end;
    local procedure CreatePickWaveJson(SSDDockPlanning2: Record "SSD Dock Planning")JsonText: Text var
        SSDDockTimeSlots: Record "SSD Dock Time Slots";
        JSonObject: JsonObject;
    begin
        JsonText:='';
        SSDDockTimeSlots.Get(SSDDockPlanning2."Location Code", SSDDockPlanning2."Dock No.", SSDDockPlanning2."Time Slot No.");
        JSonObject.Add('dockNumber', SSDDockPlanning2."Dock No.");
        JSonObject.Add('timeSlot', SSDDockTimeSlots."Starting Time");
        JSonObject.Add('itemNo', SSDDockPlanning2."Item No.");
        JSonObject.Add('itemName', SSDDockPlanning2."Item Description");
        JSonObject.Add('quantity', SSDDockPlanning2.Quantity);
        JSonObject.Add('unitOfMeasureCode', SSDDockPlanning2."Base Unit of Measure");
        JSonObject.WriteTo(JsonText);
        JsonText:='[' + JsonText + ']';
    end;
    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text)JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken)then Error('Could not find a token with key %1', TokenKey);
    end;
    var SSDAutomationSetup: Record "SSD Automation Setup";
    WarehouseSetup: Record "Warehouse Setup";
    SSDAutomationSyncMgt: Codeunit "SSD Automation Sync Mgt.";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
}
