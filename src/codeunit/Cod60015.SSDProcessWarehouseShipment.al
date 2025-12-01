codeunit 60015 "SSD Process Warehouse Shipment"
{
    TableNo = "Item Ledger Entry";

    trigger OnRun()
    begin
        WarehouseSetup.Get();
        if WarehouseSetup."SSD Internal Instance" then exit;
        if Rec."Location Code" = '' then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(Rec."Location Code")then exit;
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Outward Shipment URL");
        AccessToken:=SSDAutomationSyncMgt.GetAccessToken();
        RequestBody:=CreateShipmentJson(Rec);
        if(GuiAllowed) and (SSDAutomationSetup."Show Json")then Message(RequestBody);
        ResponseText:=SSDAutomationSyncMgt.PostAnzo(SSDAutomationSetup."Anzo Outward Shipment URL", RequestBody, AccessToken);
        JsonToken.ReadFrom(ResponseText);
        Clear(JsonObject);
        JsonObject:=JsonToken.AsObject();
        ResponseText:=GetJsonToken(JsonObject, 'status').AsValue().AsText();
        if ResponseText <> 'Success' then Error(ResponseText);
    end;
    local procedure CreateShipmentJson(ItemLedgerEntry: Record "Item Ledger Entry")JsonText: Text var
        Item: Record Item;
        JSonObject2: JsonObject;
    begin
        Item.Get(ItemLedgerEntry."Item No.");
        JsonText:='';
        JSonObject2.Add('itemNo', ItemLedgerEntry."Item No.");
        JSonObject2.Add('itemName', Item.Description);
        JSonObject2.Add('quantity', -ItemLedgerEntry.Quantity);
        JSonObject2.Add('unitofMeasureCode', Item."Base Unit of Measure");
        JSonObject2.Add('packageId', ItemLedgerEntry."Package No.");
        JSonObject2.WriteTo(JsonText);
    //JsonText := '[' + JsonText + ']';
    end;
    local procedure GetJsonToken(JsonObject3: JsonObject; TokenKey: text)JsonToken: JsonToken;
    begin
        if not JsonObject3.Get(TokenKey, JsonToken)then Error('Could not find a token with key %1', TokenKey);
    end;
    var SSDAutomationSetup: Record "SSD Automation Setup";
    WarehouseSetup: Record "Warehouse Setup";
    SSDAutomationSyncMgt: codeunit "SSD Automation Sync Mgt.";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    JsonObject: JsonObject;
    JsonToken: JsonToken;
    AccessToken: Text;
    RequestBody: Text;
    ResponseText: Text;
}
