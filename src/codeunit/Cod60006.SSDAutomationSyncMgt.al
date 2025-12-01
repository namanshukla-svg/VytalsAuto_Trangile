codeunit 60006 "SSD Automation Sync Mgt."
{
    procedure TestConnection()ConnectionSuccessful: Boolean begin
        if GetAccessToken() <> '' then ConnectionSuccessful:=true
        else
            ConnectionSuccessful:=false;
    end;
    procedure GetAccessToken()AccessToken: Text var
        Client: HttpClient;
        RequestContent: HttpContent;
        ContentHeaders: HttpHeaders;
        ResponseHeaders: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        ResponseInStream: InStream;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonText: Text;
        JsonText2: Text;
        URLText: Text;
        StartTime: Time;
        EndTime: Time;
    begin
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo User id");
        SSDAutomationSetup.TestField("Anzo Password");
        SSDAutomationSetup.TestField("Anzo Auth Url");
        Clear(JsonObject);
        Clear(JsonText);
        Clear(StartTime);
        Clear(EndTime);
        URLText:=SSDAutomationSetup."Anzo Auth Url";
        JsonObject.Add('username', SSDAutomationSetup."Anzo User id");
        JsonObject.Add('password', SSDAutomationSetup."Anzo Password");
        JsonObject.WriteTo(JsonText);
        RequestContent.WriteFrom(JsonText);
        RequestContent.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');
        Client.SetBaseAddress(URLText);
        StartTime:=Time;
        Client.Post(URLText, RequestContent, ResponseMessage);
        EndTime:=Time;
        ResponseMessage.Content.ReadAs(ResponseInStream);
        Clear(SSDAPILog);
        ResponseHeaders:=ResponseMessage.Headers;
        ResponseMessage.Content.ReadAs(JsonText2);
        SSDAPILog.InsertAPILog(SSDAutomationSetup."Anzo Receipt URL", APIMethod::POST, ResponseMessage.IsSuccessStatusCode, ResponseMessage.HttpStatusCode, JsonText, JsonText2, StartTime, EndTime);
        JsonToken.ReadFrom(JsonText2);
        Clear(JsonObject);
        JsonObject:=JsonToken.AsObject();
        JsonText2:=GetJsonToken(JsonObject, 'jwtToken').AsValue().AsText();
        AccessToken:=JsonText2;
    end;
    procedure PostAnzo(URLText: Text; BodyText: Text; AccessToken: Text)JsonText: Text var
        Client: HttpClient;
        RequestContent: HttpContent;
        ContentHeaders: HttpHeaders;
        ResponseHeaders: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        ResonseStream: InStream;
        AuthString: Text;
        StartTime: Time;
        EndTime: Time;
    begin
        Clear(StartTime);
        Clear(EndTime);
        RequestContent.WriteFrom(BodyText);
        RequestContent.GetHeaders(ContentHeaders);
        AuthString:='Bearer ' + AccessToken;
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');
        Client.SetBaseAddress(URLText);
        Client.DefaultRequestHeaders().Add('Authorization', AuthString);
        StartTime:=Time;
        Client.Post(URLText, RequestContent, ResponseMessage);
        EndTime:=Time;
        ResponseHeaders:=ResponseMessage.Headers;
        ResponseMessage.Content.ReadAs(ResonseStream);
        Clear(SSDAPILog);
        ResponseMessage.Content.ReadAs(JsonText);
        SSDAPILog.InsertAPILog(URLText, APIMethod::POST, ResponseMessage.IsSuccessStatusCode, ResponseMessage.HttpStatusCode, BodyText, JsonText, StartTime, EndTime);
        if not ResponseMessage.IsSuccessStatusCode then Error(JsonText);
    end;
    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text)JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken)then Error('Could not find a token with key %1', TokenKey);
    end;
    var SSDAPILog: Record "SSD API Log";
    SSDAutomationSetup: Record "SSD Automation Setup";
    APIMethod: Enum "Http Method";
}
