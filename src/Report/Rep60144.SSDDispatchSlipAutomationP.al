report 60144 "SSD Dispatch Slip Automation P"
{
    ApplicationArea = All;
    Caption = 'Dispatch Slip Automation Posted';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SSD Dispatch Slip NewA Posted.rdl';

    dataset
    {
        dataitem(WarehouseShipmentHeader; "Posted Whse. Shipment Header") // "Warehouse Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Posting Date";

            column(No_; "No.")
            {
            }
            //column(CurrReportPage; CurrReport.PageNo()) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(ResName; ResName)
            {
            }
            column(ResAdd; ResAdd)
            {
            }
            column(CustomerCaptionLbl; CustomerCaptionLbl)
            {
            }
            column(P_O_No_CaptionLbl; P_O_No_CaptionLbl)
            {
            }
            column(Packing_ListCaptionLbl; Packing_ListCaptionLbl)
            {
            }
            column(Dispatch_Slip_No_CaptionLbl; Dispatch_Slip_No_CaptionLbl)
            {
            }
            column(DateCaptionLbl; DateCaptionLbl)
            {
            }
            column(Work_Order__;'Work Order ')
            {
            }
            column(UserID; USERID)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(PurchaseOrderNo; "External Document No.") // PurchaseOrderNo)
            {
            }
            column(CurrReport_PAGENOCaptionLbl; CurrReport_PAGENOCaptionLbl)
            {
            }
            // column(Item_No_; ITEMNO) { }
            // column(Quantity; qtyperpac) { }
            // column(Package_Count; NoofPack) { }
            // column(Lot_No; "Lot/Batch No.") { }
            // column(Gross_Weight; ItemGrosswt) { }
            // column(pacKTaype; pacKTaype) { }
            dataitem("Warehouse Shipment Line"; "Posted Whse. Shipment Line") // "Warehouse Shipment Line")
            {
                DataItemTableView = sorting("No.")order(ascending);
                DataItemLink = "No."=field("No.");
                DataItemLinkReference = WarehouseShipmentHeader;

                column(Source_No_; "Source No.")
                {
                }
                column(Shipment_Date; "Shipment Date")
                {
                }
                column(S_No_CaptionLbl; S_No_CaptionLbl)
                {
                }
                column(Product_CodeCaptionLbl; Product_CodeCaptionLbl)
                {
                }
                column(Product_DescriptionCaptionLbl; Product_DescriptionCaptionLbl)
                {
                }
                column(Batch_No_CaptionLbl; Batch_No_CaptionLbl)
                {
                }
                column(Sales_Line___UOM_CodeCaptionLbl; Sales_Line___UOM_CodeCaptionLbl)
                {
                }
                column(QtyPerpack; QtyPerpackLbl)
                {
                }
                column(Sales_No__of_Packs_CaptionLbl; Sales_No__of_Packs_CaptionLbl)
                {
                }
                column(PackagetypeCaptionLbl; PackagetypeCaptionLbl)
                {
                }
                column(QuantityCaptionLbl; QuantityCaptionLbl)
                {
                }
                column(G__Wt__KG_CaptionLbl; G__Wt__KG_CaptionLbl)
                {
                }
                column(Notes___RemarksCaptionLbl; Notes___RemarksCaptionLbl)
                {
                }
                column(Prepared_byCaptionLbl; Prepared_byCaptionLbl)
                {
                }
                column(Auth__SignatoryCaptionLbl; Auth__SignatoryCaptionLbl)
                {
                }
                column(FM_ST_03__Rev__00_Effective_date_13_01_2012_CaptionLbl; FM_ST_03__Rev__00_Effective_date_13_01_2012_CaptionLbl)
                {
                }
                column(ItemNo_; "Item No.")
                {
                }
                trigger OnAfterGetRecord()
                var
                    Customer: Record Customer;
                begin
                    // PurchaseOrderNo := '';
                    // SalesHeader.Reset();
                    // SalesHeader.SetRange("No.", "Source No.");
                    // if SalesHeader.FindFirst() then begin
                    //     PurchaseOrderNo := SalesHeader."External Document No.";
                    //     CustomerName := SalesHeader."Sell-to Customer Name";
                    // end;
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Document No.", "Warehouse Shipment Line"."Posted Source No.");
                    ReservationEntry.SetFilter("Lot No.", '<>%1', '');
                    if ReservationEntry.FindFirst()then begin
                        if Customer.get(ReservationEntry."Source No.")then CustomerName:=Customer.Name;
                    end;
                    item.reset();
                    item.SetRange("No.", "Warehouse Shipment Line"."Item No.");
                    if item.FindFirst()then pacKTaype:=format(item."SSD Packing");
                    ItemGrosswt:=item."Gross Weight";
                    //  if SSDTempDISPPACK.FindSet() then SSDTempDISPPACK.DeleteAll();
                    // if SSDtemporaryDisppack.findset() then SSDtemporaryDisppack.deleteall();
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Document No.", "Warehouse Shipment Line"."Posted Source No.");
                    ReservationEntry.SetFilter("Lot No.", '<>%1', '');
                    if ReservationEntry.FindSet()then repeat if not SSDtemporaryDisppack.Get(ReservationEntry."Document No.", ReservationEntry."Item No.", ReservationEntry."Lot No.", ReservationEntry."Package No.")then begin
                                SSDtemporaryDisppack.Init();
                                SSDtemporaryDisppack."No.":=ReservationEntry."Document No.";
                                SSDtemporaryDisppack."Item No.":=ReservationEntry."Item No.";
                                SSDtemporaryDisppack.Quantity:=ReservationEntry.Quantity;
                                SSDtemporaryDisppack."Lot No":=ReservationEntry."Lot No.";
                                SSDtemporaryDisppack."Package No":=ReservationEntry."Package No.";
                                SSDtemporaryDisppack."Package Count":=1;
                                SSDtemporaryDisppack.Insert();
                            end;
                        // else begin
                        //     SSDtemporaryDisppack.Quantity += ReservationEntry.Quantity;
                        //     SSDtemporaryDisppack.Modify();
                        // end;
                        until ReservationEntry.Next() = 0;
                // SSDtemporaryDisppack.Reset();
                // SSDtemporaryDisppack.SetRange("No.", "Warehouse Shipment Line"."Source No.");
                // if SSDtemporaryDisppack.findset() then begin
                //     repeat
                //         //   if not SSDTempDISPPACK.Get(SSDtemporaryDisppack."No.", SSDtemporaryDisppack."Item No.", SSDtemporaryDisppack.Quantity, SSDtemporaryDisppack."Lot No") then begin
                //         if not SSDTempDISPPACK.Get(SSDtemporaryDisppack."No.", SSDtemporaryDisppack."Item No.", SSDtemporaryDisppack."Lot No", SSDtemporaryDisppack."Package No") then begin
                //             SSDTempDISPPACK.Init();
                //             SSDTempDISPPACK."No." := SSDtemporaryDisppack."No.";
                //             SSDTempDISPPACK."Item No." := SSDtemporaryDisppack."Item No.";
                //             SSDTempDISPPACK.Quantity := SSDtemporaryDisppack.Quantity;
                //             SSDTempDISPPACK."Lot No" := SSDtemporaryDisppack."Lot No";
                //             SSDTempDISPPACK."Package No" := SSDtemporaryDisppack."Package No";
                //             SSDTempDISPPACK."Package Count" := 1;
                //             SSDTempDISPPACK.Insert();
                //         end
                //         else begin
                //             SSDTempDISPPACK."Package Count" := SSDTempDISPPACK."Package Count" + 1;
                //             SSDTempDISPPACK.Modify();
                //         end;
                //     until SSDtemporaryDisppack.Next() = 0;
                //     SSDTempDISPPACK.Reset();
                //     if SSDTempDISPPACK.FindSet() then
                //         repeat
                //             CRLF := TypeHelper.CRLFSeparator();
                //         until SSDTempDISPPACK.Next() = 0;
                // end;
                end;
            // end;
            }
            trigger OnPreDataItem()
            var
            begin
                if not StateRec.Get(CompanyInfo."State Code")then StateRec.Init();
                ResName:=CompanyInfo.Name;
                ResAdd:=CopyStr(CompanyInfo.Address + ', ' + CompanyInfo."Address 2" + ', ' + CompanyInfo.City + '-' + CompanyInfo."Post Code" + ', ' + StateRec.Description + ', India', 1, 250);
                ResAdd:=UpperCase(ResAdd);
            end;
            trigger OnAfterGetRecord()
            var
            begin
            end;
        }
        dataitem("SSD Temp Dispatch Slip"; "SSD Temp Dispatch Pack Posted") // "SSD Temp Dispatch Slip")
        {
            // DataItemLinkReference = "Warehouse Shipment Line";
            // DataItemLink = "No." = field("Source No.");
            column(Srno; Srno)
            {
            }
            column(Quantity; ABS(Quantity))
            {
            }
            column(Item_No_; "Item No.")
            {
            }
            column(Package_Count; "Package Count")
            {
            }
            column(Lot_No; "Lot No")
            {
            }
            column(Gross_Weight; ABS(ItemGrosswt * Quantity2))
            {
            }
            column(pacKTaype; pacKTaype)
            {
            }
            column(Quantity1; ABS(Quantity2))
            {
            }
            column(Desc; Desc)
            {
            }
            column(Unit_of_Measure_Code; Unit_of_Measure_Code)
            {
            }
            column(Package_No; "Package No")
            {
            }
            trigger OnPreDataItem()
            var
            begin
                Srno:=0;
                ItemGrosswt:=0;
                Quantity2:=0;
            // J := 0;
            // packcounter := 0;
            // NoofPack := 0;
            end;
            trigger OnAfterGetRecord()
            var
            begin
                Srno:=Srno + 1;
                Quantity2:="SSD Temp Dispatch Slip".Quantity * "SSD Temp Dispatch Slip"."Package Count";
                //GrWT:=;
                item.reset();
                item.SetRange("No.", "Item No.");
                if item.FindFirst()then pacKTaype:=format(item."SSD Packing");
                ItemGrosswt:=item."Gross Weight";
                Desc:=item.Description + ' ' + item."Description 2";
                Unit_of_Measure_Code:=item."Base Unit of Measure";
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        //   DisppatchTempSlip: Record "SSD Temp Dispatch Slip";
        SSDtemporaryDisppack: Record "SSD Temp Dispatch Pack Posted";
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        //   if DisppatchTempSlip.FindSet() then DisppatchTempSlip.DeleteAll();
        if SSDtemporaryDisppack.FindSet()then SSDtemporaryDisppack.DeleteAll();
    end;
    var CompanyInfo: Record "Company Information";
    item: Record Item;
    ReservationEntry: Record "Item Ledger Entry"; //"Reservation Entry";
    SalesHeader: Record "Sales Header";
    SSDtemporaryDisppack: Record "SSD Temp Dispatch Pack Posted";
    // SSDTempDISPPACK: Record "SSD Temp Dispatch Slip";
    // SSDTempDISPPACK1: Record "SSD Temp Dispatch Slip";
    StateRec: Record State;
    // warhouseShipmentHeader: Record "Warehouse Shipment Header";
    TypeHelper: Codeunit "Type Helper";
    // ITEMNO: Code[20];
    // SalesLine: Record "Sales Line";
    PurchaseOrderNo: Code[40];
    // "Lot/Batch No.": Code[50];
    ItemGrosswt: Decimal;
    // GrWT: Decimal;
    Quantity2: Decimal;
    // qtyperpac: Decimal;
    // J: Integer;
    // NoofPack: integer;
    Srno: Integer;
    Auth__SignatoryCaptionLbl: label 'Auth. Signatory';
    Batch_No_CaptionLbl: label 'Batch No';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    CustomerCaptionLbl: label 'Customer';
    DateCaptionLbl: label 'Date';
    Dispatch_Slip_No_CaptionLbl: label 'Dispatch Slip No.';
    FM_ST_03__Rev__00_Effective_date_13_01_2012_CaptionLbl: label '<FM-ST-03, Rev. 00 Effective date 13.01.2012>';
    G__Wt__KG_CaptionLbl: label 'G. Wt (KG)';
    Notes___RemarksCaptionLbl: label 'Notes / Remarks';
    P_O_No_CaptionLbl: label 'P.O.No:';
    PackagetypeCaptionLbl: label 'Package Type';
    Packing_ListCaptionLbl: label 'Packing List';
    Prepared_byCaptionLbl: label 'Prepared by';
    Product_CodeCaptionLbl: label 'Product Code';
    Product_DescriptionCaptionLbl: label 'Product Description';
    QtyPerpackLbl: Label 'Qty Per Pack';
    QuantityCaptionLbl: label 'Quantity';
    S_No_CaptionLbl: label 'S.No.';
    Sales_Line___UOM_CodeCaptionLbl: label 'UOM/Qty';
    Sales_No__of_Packs_CaptionLbl: label 'No of Pack''s';
    pacKTaype: text;
    CRLF: Text[2];
    CustomerName: Text[100];
    Desc: Text[250];
    ResAdd: Text[250];
    ResName: Text[250];
    Unit_of_Measure_Code: Text[250];
}
