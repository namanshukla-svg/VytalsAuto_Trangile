report 60145 "Return Received not Invoiced1"
{
    ApplicationArea = All;
    Caption = 'Return Received But not Invoiced - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(returnReceiptLine; "Return Receipt Line")
        {
            RequestFilterFields = "Posting Date";
            DataItemTableView = where("Return Qty. Rcd. Not Invd."=filter(>0));

            trigger OnAfterGetRecord()
            begin
                CustomerName:='';
                if CustomerRec.Get("Sell-to Customer No.")then CustomerName:=CustomerRec.Name;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(returnReceiptLine."Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(returnReceiptLine."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                //ExcelBuffer.AddColumn(PurchRcptLine."Order No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                //  ExcelBuffer.AddColumn(PurchRcptLine."Bill No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(returnReceiptLine."Sell-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(CustomerName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(returnReceiptLine."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(returnReceiptLine.Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(returnReceiptLine."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(returnReceiptLine.Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(returnReceiptLine."Return Qty. Rcd. Not Invd.", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        CreateHeading();
    end;
    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;
    var ExcelBuffer: Record "Excel Buffer";
    CustomerRec: Record customer;
    CustomerName: Text;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Document No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Date);
        //   ExcelBuffer.AddColumn('Order No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        // ExcelBuffer.AddColumn('Vendor Document No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Qty Received', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Return Qty. Rcd. Not Invd.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Return Received But not Invoiced - MIS');
        ExcelBuffer.WriteSheet('Return Received But not Invoiced - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Return Received But not Invoiced - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
