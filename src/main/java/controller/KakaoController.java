package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.json.simple.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import dto.KakaoPayApprovalDTO;
import dto.KakaoPayReadyDTO;

public class KakaoController {

   ////////////////////// 카카오페이///////////////////////////////////////
   private static final String HOST = "https://kapi.kakao.com";
   private static KakaoPayReadyDTO kakaoPayReadyVO;
   private static KakaoPayApprovalDTO KakaoPayApprovalDTO;

   public static String kakaoPayReady(int sellSum, int usePoint, String cartinfoList, String person, String phone, String address) {

      RestTemplate restTemplate = new RestTemplate();

      // 서버로 요청할 Header
      HttpHeaders headers = new HttpHeaders();
      headers.add("Authorization", "KakaoAK " + "4ce75f9cd824ff86abe12e00fdea1891");
      headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
      headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");

      // 서버로 요청할 Body
      MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
      params.add("cid", "TC0ONETIME");//임시 가맹점 코드. 필수O
      params.add("partner_order_id", "1001");//가맹점 주문번호 최대 100자. 필수O
      params.add("partner_user_id", "NANALAND");//가맹점 회원 id 최대 100자. 필수O
      params.add("item_name", cartinfoList);//상품명 최대 100자. 필수O
      params.add("quantity", "1");//상품수량. 필수O
      params.add("total_amount", sellSum+"");//상품 총액. 필수O
      params.add("tax_free_amount", "100");//상품 비과세 금액. 필수O
      params.add("approval_url", "http://localhost:8090/myfinal/kakaoPaySuccess.do?person="+person+"&usePoint="+usePoint+"&phone="+phone+"&address="+address);//결제 성공시 redirect url 최대 255자. 필수O
      params.add("cancel_url", "http://localhost:8090/myfinal/kakaoPayCancel");//결제 취소시 redirect url 최대 255자. 필수O
      params.add("fail_url", "http://localhost:8090/myfinal/kakaoPaySuccessFail");//결제 실패시 redirect url 최대 255자. 필수O

      HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);

      try {
         kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body,
               KakaoPayReadyDTO.class);
         // kakaoPayReadyVO.getNext_redirect_pc_url();
         System.out.println("카카오페이 url: " + kakaoPayReadyVO.getNext_redirect_pc_url());
         return kakaoPayReadyVO.getNext_redirect_pc_url();//결제 대기 화면

      } catch (RestClientException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } catch (URISyntaxException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

      return "/실패ㅠㅠ ";
   }
   
    public static KakaoPayApprovalDTO kakaoPayInfo(String pg_token) {
           RestTemplate restTemplate = new RestTemplate();
    
           // 서버로 요청할 Header
           HttpHeaders headers = new HttpHeaders();
           headers.add("Authorization", "KakaoAK " + "4ce75f9cd824ff86abe12e00fdea1891");
         headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
           headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
    
           // 서버로 요청할 Body
           MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
           params.add("cid", "TC0ONETIME");//가맹점 코드 10자 필수
           params.add("tid", kakaoPayReadyVO.getTid());//결제 고유번호 결제준비 API의 응답에서 얻을 수 있음. 필수
           params.add("partner_order_id", "1001");//가맹점 주문번호 결제준비 API에서 요청한값과 일치해야 함. 필수
           params.add("partner_user_id", "NANALAND");//가맹점 회원 id. 결제준비 API에서 요청한 값과 일치해야 함. 필수
           params.add("pg_token", pg_token);//결제승인 요청을 인증하는 토큰. 사용자가 결제수단 선택 완료시 approval_url로 redirection해줄 때 pg_token을 query string으로 넘겨줌. 필수O
        
           HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
           
           try {
              KakaoPayApprovalDTO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalDTO.class);
               System.out.println("KakaoPayApprovalVO : " + KakaoPayApprovalDTO);
             
               return KakaoPayApprovalDTO;
           
           } catch (RestClientException e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
           } catch (URISyntaxException e) {
               // TODO Auto-generated catch block
               e.printStackTrace();
           }
           System.out.println("KakaoPayApprovalVO: " + KakaoPayApprovalDTO);
           return null;
       }
   ////////////////////////////// END 카카오페이///////////////////////////////

   private final static String K_CLIENT_ID = "f57ab38b61371ae2d774bffa2850bf28";
   private final static String K_REDIRECT_URI = "http://localhost:8090/myfinal/kakaologin.do";
   String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?client_id=f57ab38b61371ae2d774bffa2850bf28&redirect_uri=http://localhost:8090/myfinal/kakaologin.do&response_type=code";

   public static String getAuthorizationUrl(HttpSession session) {

      String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?" + "client_id=" + K_CLIENT_ID + "&redirect_uri="
            + K_REDIRECT_URI + "&response_type=code";
      return kakaoUrl;
   }

   public static JsonNode getAccessToken(String autorize_code) {
      final String RequestUrl = "https://kauth.kakao.com/oauth/token";

      final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
      postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
      postParams.add(new BasicNameValuePair("client_id", "f57ab38b61371ae2d774bffa2850bf28")); // REST API KEY
      postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8090/myfinal/kakaologin.do")); // 리다이렉트
                                                                                    // URI
      postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정중 얻은 code 값

      final HttpClient client = HttpClientBuilder.create().build();
      final HttpPost post = new HttpPost(RequestUrl);
      JsonNode returnNode = null;

      try {
         post.setEntity(new UrlEncodedFormEntity(postParams));
         final HttpResponse response = client.execute(post);
         // final int responseCode = response.getStatusLine().getStatusCode();

         // System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
         // System.out.println("Post parameters : " + postParams);
         // System.out.println("Response Code : " + responseCode);

         // JSON 형태 반환값 처리
         ObjectMapper mapper = new ObjectMapper();
         returnNode = mapper.readTree(response.getEntity().getContent());

      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      } catch (ClientProtocolException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      } finally {
         // clear resources
      }

      return returnNode;

   }

   public static JsonNode getKakaoUserInfo(JsonNode accessToken) {

      final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
      final HttpClient client = HttpClientBuilder.create().build();
      final HttpPost post = new HttpPost(RequestUrl);

      // add header
      post.addHeader("Authorization", "Bearer " + accessToken);

      JsonNode returnNode = null;

      try {
         final HttpResponse response = client.execute(post);
         // final int responseCode = response.getStatusLine().getStatusCode();

         // System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
         // .out.println("Response Code : " + responseCode);

         // JSON 형태 반환값 처리
         ObjectMapper mapper = new ObjectMapper();
         returnNode = mapper.readTree(response.getEntity().getContent());

      } catch (ClientProtocolException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      } finally {
         // clear resources
      }

      return returnNode;
   }

}