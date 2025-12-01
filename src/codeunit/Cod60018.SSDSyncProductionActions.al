codeunit 60018 "SSD Sync Production Actions"
{
    Permissions = tabledata "Item Ledger Entry"=rm;

    procedure GetBlendingComponents(ProdOrderComponent: Record "Prod. Order Component")
    var
        ProdOrderComponent2: Record "Prod. Order Component";
        ProdOrderComponent3: Record "Prod. Order Component";
    begin
        ProdOrderComponent.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ProdOrderComponent."Location Code")then Error(LocationNotAutomatedErr, ProdOrderComponent."Location Code");
        ProdOrderComponent2.Reset();
        ProdOrderComponent2.SetRange(Status, ProdOrderComponent.Status);
        ProdOrderComponent2.SetRange("Prod. Order No.", ProdOrderComponent."Prod. Order No.");
        ProdOrderComponent2.SetRange("Prod. Order Line No.", ProdOrderComponent."Prod. Order Line No.");
        ProdOrderComponent2.SetRange("SSD Consumption Station", ProdOrderComponent2."SSD Consumption Station"::Blending);
        ProdOrderComponent2.SetRange("SSD WMS Request Sent", false);
        if ProdOrderComponent2.FindSet()then begin
            if SyncProdPick(ProdOrderComponent2)then begin
                ProdOrderComponent3.Get(ProdOrderComponent2.Status, ProdOrderComponent2."Prod. Order No.", ProdOrderComponent2."Prod. Order Line No.", ProdOrderComponent2."Line No.");
                ProdOrderComponent3."SSD WMS Request Sent":=true;
                ProdOrderComponent3.Modify();
                Commit();
            end;
        end
        else
            Error(NothingToSyncErr);
    end;
    procedure GetFillingComponents(ProdOrderComponent: Record "Prod. Order Component")
    var
        ProdOrderComponent2: Record "Prod. Order Component";
        ProdOrderComponent3: Record "Prod. Order Component";
    begin
        ProdOrderComponent.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ProdOrderComponent."Location Code")then Error(LocationNotAutomatedErr, ProdOrderComponent."Location Code");
        ProdOrderComponent2.Reset();
        ProdOrderComponent2.SetRange(Status, ProdOrderComponent.Status);
        ProdOrderComponent2.SetRange("Prod. Order No.", ProdOrderComponent."Prod. Order No.");
        ProdOrderComponent2.SetRange("Prod. Order Line No.", ProdOrderComponent."Prod. Order Line No.");
        ProdOrderComponent2.SetRange("SSD Consumption Station", ProdOrderComponent2."SSD Consumption Station"::Filling);
        ProdOrderComponent2.SetRange("SSD WMS Request Sent", false);
        if ProdOrderComponent2.FindSet()then begin
            if SyncProdPick(ProdOrderComponent2)then begin
                ProdOrderComponent3.Get(ProdOrderComponent2.Status, ProdOrderComponent2."Prod. Order No.", ProdOrderComponent2."Prod. Order Line No.", ProdOrderComponent2."Line No.");
                ProdOrderComponent3."SSD WMS Request Sent":=true;
                ProdOrderComponent3.Modify();
                Commit();
            end;
        end
        else
            Error(NothingToSyncErr);
    end;
    procedure SyncProductionOutput(ProductionOrder: Record "Production Order")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
    begin
        ProductionOrder.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ProductionOrder."Location Code")then Error(LocationNotAutomatedErr, ProductionOrder."Location Code");
        ItemLedgerEntry.SetCurrentKey("Order Type", "Order No.", "Order Line No.", "Entry Type", "Prod. Order Comp. Line No.");
        ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        ItemLedgerEntry.SetRange("SSD Entry Synced", false);
        if ItemLedgerEntry.FindSet()then repeat if SyncProductionOutput(ItemLedgerEntry)then begin
                    ItemLedgerEntry2.Get(ItemLedgerEntry."Entry No.");
                    ItemLedgerEntry2."SSD Entry Synced":=true;
                    ItemLedgerEntry2.Modify();
                    Commit();
                end;
            until ItemLedgerEntry.Next() = 0;
    end;
    procedure SyncProductionOutput(ItemLedgerEntry: Record "Item Ledger Entry"): Boolean var
    //JsonObject: JsonObject;
    //JsonToken: JsonToken;
    begin
        WarehouseSetup.Get();
        if WarehouseSetup."SSD Internal Instance" then exit(false);
        if ItemLedgerEntry."Location Code" = '' then exit(false);
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ItemLedgerEntry."Location Code")then exit(false);
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Production Output URL");
        AccessToken:=SSDAutomationSyncMgt.GetAccessToken();
        RequestBody:=CreatePutAwayJson(ItemLedgerEntry);
        if(GuiAllowed) and (SSDAutomationSetup."Show Json")then Message(RequestBody);
        ResponseText:=SSDAutomationSyncMgt.PostAnzo(SSDAutomationSetup."Anzo Production Output URL", RequestBody, AccessToken);
        //No Response text is received from Anzo
        // JsonToken.ReadFrom(ResponseText);
        // Clear(JsonObject);
        // JsonObject := JsonToken.AsObject();
        // ResponseText := GetJsonToken(JsonObject, 'status').AsValue().AsText();
        // if ResponseText <> 'Success' then
        //     Error(ResponseText);
        exit(true);
    end;
    procedure SyncProductionConsumption(ItemLedgerEntry: Record "Item Ledger Entry"): Boolean var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
    begin
        WarehouseSetup.Get();
        if WarehouseSetup."SSD Internal Instance" then exit(false);
        if ItemLedgerEntry."Location Code" = '' then exit(false);
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ItemLedgerEntry."Location Code")then exit(false);
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Prod. Consumption URL");
        AccessToken:=SSDAutomationSyncMgt.GetAccessToken();
        RequestBody:=CreateConsumptionJson(ItemLedgerEntry);
        if(GuiAllowed) and (SSDAutomationSetup."Show Json")then Message(RequestBody);
        ResponseText:=SSDAutomationSyncMgt.PostAnzo(SSDAutomationSetup."Anzo Prod. Consumption URL", RequestBody, AccessToken);
        JsonToken.ReadFrom(ResponseText);
        Clear(JsonObject);
        JsonObject:=JsonToken.AsObject();
        ResponseText:=GetJsonToken(JsonObject, 'status').AsValue().AsText();
        if ResponseText <> 'Success' then Error(ResponseText);
        exit(true);
    end;
    local procedure SyncProdPick(ProdOrderComponent: Record "Prod. Order Component"): Boolean var
    //JsonObject: JsonObject;
    //JsonToken: JsonToken;
    begin
        WarehouseSetup.Get();
        if WarehouseSetup."SSD Internal Instance" then exit(false);
        if ProdOrderComponent."Location Code" = '' then exit(false);
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ProdOrderComponent."Location Code")then exit(false);
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Production Pick URL");
        AccessToken:=SSDAutomationSyncMgt.GetAccessToken();
        RequestBody:=CreateProdPickJson(ProdOrderComponent);
        if(GuiAllowed) and (SSDAutomationSetup."Show Json")then Message(RequestBody);
        ResponseText:=SSDAutomationSyncMgt.PostAnzo(SSDAutomationSetup."Anzo Production Pick URL", RequestBody, AccessToken);
        // JsonToken.ReadFrom(ResponseText);
        // Clear(JsonObject);
        // JsonObject := JsonToken.AsObject();
        // ResponseText := GetJsonToken(JsonObject, 'status').AsValue().AsText();
        // if ResponseText <> 'Success' then
        //     Error(ResponseText);
        exit(true);
    end;
    local procedure CreateProdPickJson(ProdOrderComponent: Record "Prod. Order Component")JsonText: Text var
        Item: Record Item;
        JSonObject: JsonObject;
    begin
        ProdOrderComponent.TestField("Qty. To Consume");
        SSDAutomationSetup.Get();
        Item.Get(ProdOrderComponent."Item No.");
        JsonText:='';
        JSonObject.Add('productionOrder', ProdOrderComponent."Prod. Order No.");
        JSonObject.Add('productionDate', format(Today, 0, '<Year4>-<Month,2>-<Day,2>'));
        if ProdOrderComponent."SSD Consumption Station" = ProdOrderComponent."SSD Consumption Station"::Blending then JSonObject.Add('productionStation', SSDAutomationSetup."Blending Station No.")
        else
            JSonObject.Add('productionStation', SSDAutomationSetup."Filling Station No.");
        JSonObject.Add('timeSlot', GetCurrentTime());
        JSonObject.Add('itemNo', ProdOrderComponent."Item No.");
        JSonObject.Add('itemName', Item.Description);
        JSonObject.Add('quantity', ProdOrderComponent."Qty. To Consume");
        JSonObject.Add('unitofMeasureCode', ProdOrderComponent."Unit of Measure Code");
        JSonObject.WriteTo(JsonText);
        JsonText:='[' + JsonText + ']';
    end;
    procedure CreatePutAwayJson(ItemLedgerEntry: Record "Item Ledger Entry")JsonText: Text var
        Item: Record Item;
        JSonObject: JsonObject;
    begin
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Output Station No.");
        Item.Get(ItemLedgerEntry."Item No.");
        JsonText:='';
        JSonObject.Add('productionStation', SSDAutomationSetup."Output Station No.");
        JSonObject.Add('itemNo', ItemLedgerEntry."Item No.");
        JSonObject.Add('itemName', Item.Description);
        JSonObject.Add('quantity', ItemLedgerEntry.Quantity);
        JSonObject.Add('unitofMeasureCode', Item."Base Unit of Measure");
        JSonObject.Add('packageId', ItemLedgerEntry."Package No.");
        JSonObject.Add('lotNo', ItemLedgerEntry."Lot No.");
        JSonObject.Add('netWeight', Round(ItemLedgerEntry.Quantity * Item."Net Weight", 0.00001, '='));
        JSonObject.Add('grossWeight', Round(ItemLedgerEntry.Quantity * Item."Gross Weight", 0.00001, '='));
        JSonObject.Add('manufacturingDate', format(ItemLedgerEntry."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>'));
        if ItemLedgerEntry."Expiration Date" <> 0D then JSonObject.Add('expiryDate', format(ItemLedgerEntry."Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>'))
        else
            JSonObject.Add('expiryDate', format(ItemLedgerEntry."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>'));
        //SSD_Sunil
        JSonObject.Add('productionDate', format(ItemLedgerEntry."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>'));
        JSonObject.Add('productionOrder', ItemLedgerEntry."Order No.");
        //SSD_Sunil
        JSonObject.WriteTo(JsonText);
        JsonText:='[' + JsonText + ']';
    end;
    procedure CreatePutAwayJson(ProdOrderLine: Record "Prod. Order Line"; ReservationEntry: Record "Reservation Entry")JsonText: Text var
        Item: Record Item;
        JSonObject: JsonObject;
    begin
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Output Station No.");
        Item.Get(ProdOrderLine."Item No.");
        JsonText:='';
        JSonObject.Add('productionStation', SSDAutomationSetup."Output Station No.");
        JSonObject.Add('itemNo', Item."No.");
        JSonObject.Add('itemName', Item.Description);
        JSonObject.Add('quantity', ReservationEntry."Qty. to Handle (Base)");
        JSonObject.Add('unitofMeasureCode', Item."Base Unit of Measure");
        JSonObject.Add('packageId', ReservationEntry."Package No.");
        JSonObject.Add('lotNo', ReservationEntry."Lot No.");
        JSonObject.Add('netWeight', Round(ReservationEntry.Quantity * Item."Net Weight", 0.00001, '='));
        JSonObject.Add('grossWeight', Round(ReservationEntry.Quantity * Item."Gross Weight", 0.00001, '='));
        JSonObject.Add('manufacturingDate', format(Today, 0, '<Year4>-<Month,2>-<Day,2>'));
        if ReservationEntry."Expiration Date" <> 0D then JSonObject.Add('expiryDate', format(ReservationEntry."Expiration Date", 0, '<Year4>-<Month,2>-<Day,2>'))
        else
            JSonObject.Add('expiryDate', format(Today, 0, '<Year4>-<Month,2>-<Day,2>'));
        //SSD_Sunil
        JSonObject.Add('productionDate', format(ProdOrderLine."Starting Date", 0, '<Year4>-<Month,2>-<Day,2>'));
        JSonObject.Add('productionOrder', ProdOrderLine."Prod. Order No.");
        //SSD_Sunil
        JSonObject.WriteTo(JsonText);
        JsonText:='[' + JsonText + ']';
    end;
    local procedure CreateConsumptionJson(ItemLedgerEntry: Record "Item Ledger Entry")JsonText: Text var
        Item: Record Item;
        JSonObject: JsonObject;
    begin
        Item.Get(ItemLedgerEntry."Item No.");
        JsonText:='';
        JSonObject.Add('itemNo', ItemLedgerEntry."Item No.");
        JSonObject.Add('itemName', Item.Description);
        JSonObject.Add('packageId', ItemLedgerEntry."Package No.");
        JSonObject.Add('lotNo', ItemLedgerEntry."Lot No.");
        JSonObject.Add('quantity', -ItemLedgerEntry.Quantity);
        JSonObject.Add('unitofMeasureCode', Item."Base Unit of Measure");
        JSonObject.WriteTo(JsonText);
    //JsonText := '[' + JsonText + ']';
    end;
    local procedure GetJsonToken(JsonObject3: JsonObject; TokenKey: text)JsonToken: JsonToken;
    begin
        if not JsonObject3.Get(TokenKey, JsonToken)then Error('Could not find a token with key %1', TokenKey);
    end;
    local procedure GetCurrentTime()CurrentTimeTxt: Text var
        TypeHelper: Codeunit "Type Helper";
        HoursInt: Integer;
        MinutesInt: Integer;
        SecondsInt: Integer;
        HoursTxt: Text;
        MinutesTxt: Text;
        SecondsTxt: Text;
    begin
        TypeHelper.GetHMSFromTime(HoursInt, MinutesInt, SecondsInt, Time);
        HoursTxt:=Format(HoursInt);
        if StrLen(HoursTxt) = 1 then HoursTxt:='0' + HoursTxt;
        MinutesTxt:=Format(MinutesInt);
        if StrLen(MinutesTxt) = 1 then MinutesTxt:='0' + MinutesTxt;
        SecondsTxt:=Format(SecondsInt);
        if StrLen(SecondsTxt) = 1 then SecondsTxt:='0' + SecondsTxt;
        CurrentTimeTxt:=HoursTxt + ':' + MinutesTxt + ':' + SecondsTxt;
    end;
    var SSDAutomationSetup: Record "SSD Automation Setup";
    WarehouseSetup: Record "Warehouse Setup";
    SSDAutomationSyncMgt: codeunit "SSD Automation Sync Mgt.";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    LocationNotAutomatedErr: Label 'Location %1 is not automated plant', Comment = '%1 = Location Code';
    NothingToSyncErr: Label 'There is nothing to sync';
    AccessToken: Text;
    RequestBody: Text;
    ResponseText: Text;
}
