codeunit 60024 "SSD Warehouse Receipt Mgt."
{
    procedure SyncWarehouseReceiptLine(WarehouseReceiptLine: Record "Warehouse Receipt Line"; ReservationEntry: Record "Reservation Entry"; var APIStatus: Boolean; var ErrorText: Text)
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
        WarehouseReceiptLine.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptLine."Location Code")then exit;
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Receipt URL");
        AccessToken:=SSDAutomationSyncManagement.GetAccessToken();
        RequestBody:=CreateReceiptLineJson(WarehouseReceiptLine, ReservationEntry);
        if SSDAutomationSetup."Show Json" then Message(RequestBody);
        ResponseText:=SSDAutomationSyncManagement.PostAnzo(SSDAutomationSetup."Anzo Receipt URL", RequestBody, AccessToken);
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
    procedure CreateReceiptLineJson(WarehouseReceiptLine: Record "Warehouse Receipt Line"; ReservationEntry: Record "Reservation Entry")JsonText: Text var
        Item: Record Item;
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        JSonObject: JsonObject;
    begin
        WarehouseReceiptHeader.Get(WarehouseReceiptLine."No.");
        Item.Get(WarehouseReceiptLine."Item No.");
        Item.TestField("SSD Storage Type");
        JsonText:='';
        JSonObject.Add('receiptNo', WarehouseReceiptLine."No.");
        JSonObject.Add('receiptDate', WarehouseReceiptHeader."Posting Date");
        JSonObject.Add('itemNo', WarehouseReceiptLine."Item No.");
        JSonObject.Add('itemName', WarehouseReceiptLine.Description);
        JSonObject.Add('quantity', ReservationEntry."Qty. to Handle (Base)");
        JSonObject.Add('unitofMeasureCode', Item."Base Unit of Measure");
        JSonObject.Add('packageId', ReservationEntry."Package No.");
        JSonObject.Add('lotnumber', ReservationEntry."Lot No.");
        JSonObject.Add('docknumber', WarehouseReceiptHeader."SSD Dock No.");
        JSonObject.Add('grossWeight', ReservationEntry."SSD Gross Weight");
        JSonObject.Add('expiryDate', ReservationEntry."Expiration Date");
        JSonObject.Add('palletTypePreference', Item."SSD Pallet Type");
        JSonObject.Add('storageType', Format(Item."SSD Storage Type"));
        JSonObject.WriteTo(JsonText);
        JsonText:='[' + JsonText + ']';
    end;
    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text)JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken)then Error('Could not find a token with key %1', TokenKey);
    end;
    var SSDAutomationSetup: Record "SSD Automation Setup";
    WarehouseSetup: Record "Warehouse Setup";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    SSDAutomationSyncManagement: Codeunit "SSD Automation Sync Mgt.";
}
