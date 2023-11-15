<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>풀무원 녹즙 | 맞춤큐레이션</title>
<meta name="description" content="하루 한 병 건강한 습관 풀무원녹즙, 신선한 채소와 과일의 영양을 매일 아침 배송합니다.">
<meta name="viewport"     content="width=device-width,initial-scale=1.0">
<script src="/resources/assets/js/jquery-2.1.4.min.js"></script>
<script src="/resources/assets/js/jquery.form.min.js"></script>

<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/assets/css/bootstrap-fdd.css">
<script src="/resources/assets/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js" ></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js" integrity="sha384-DRe+1gYJauFEenXeWS8TmYdBmDUqnR5Rcw7ax4KTqOxXWd4NAMP2VPU5H69U7yP9" crossorigin="anonymous"></script>
<script src="/resources/assets/js/clipboard.min.js"></script>
<script src="/resources/assets/js/fdd.js"></script>
<script src="/resources/assets/js/request.js"></script>
<link rel="stylesheet" href="/resources/assets/css/contents_v1.css">

<link rel="stylesheet" href="/resources/assets/css/owl.carousel.min.css"/>
<link rel="stylesheet" href="/resources/assets/css/owl.theme.default.css"/>
<script src="/resources/assets/js/owl.carousel.min.js"></script>

<link rel="stylesheet" href="/resources/assets/css/layout_style.css">
<link rel="stylesheet" href="/resources/assets/css/a-guide.css">
<link rel="stylesheet" href="/resources/assets/css/contents2.css">

<link rel="stylesheet" href="/resources/assets/css/daterangepicker.css"/>
<script src="/resources/assets/js/daterangepicker.js"></script>
<link rel="stylesheet" href="/resources/assets/css/style.css">
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/images/pul_favicon.png">

<style type="text/css">
img {
    overflow-clip-margin: content-box;
    overflow: clip;
}
</style>
</head>
<body>
<div class="wrapper">
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
<main class="products">
<!--S:container-wrapper -->
<div id="container-wrapper" class="container-wrapper"> <!-- TODO : 회원쪽 페이지들은 <div class="container-wrapper member"> -->


<script type="text/javascript">
  var singleYn = 'N' == 'Y';
  $(function () {

    sessionStorage.removeItem('req1');
    sessionStorage.removeItem('req2');
    sessionStorage.removeItem('req3');

    function getItems(lbl) {
      var items = {};
      $("input[name='itemCode']").each(function (i, item) {
        var el = $(item);
        if (el.is(":checked") || el.is("[type='hidden']")) {
          var itemCode = el.val();
          if (singleYn) {
            items[itemCode] = [1, 1, 1, 1, 1];
          } else {
            var d = items[itemCode] || [0, 0, 0, 0, 0];
            d[i] += 1;
            items[itemCode] = d;
          }
        }
      })

      var orderItems = [];
      for (var key of Object.keys(items)) {
        orderItems.push({
          itemCode: key,
          [lbl]: items[key]
        });
      }
      return orderItems;
    }

    $('#orderBtn').click(function () {
      if (!window.is_signed) {
        alert('로그인이 필요한 서비스입니다.', function () {
          location.href = '/member/login?redirectUrl=' + encodeURIComponent(location.href);
        });
        return;
      }

      var orderItems = getItems('dayQty');
      if (orderItems.length === 0) {
        alert("상품을 선택해주세요.");
        return;
      }

      window.orderProcess({ item: orderItems });
    });

    $("#cartBtn").click(function () {
      var orderItems = getItems('qty');
      if (orderItems.length === 0) {
        alert("상품을 선택해주세요.");
        return;
      }
      addCarts("daily", orderItems);
    });

  })
  
    $(document).ready(function () {
    $("[data-item-index]").each(function () {
      var subData = $(this).data();
      var ix = subData.itemIndex + 1;
      data["item_0" + ix + "_img"] = subData.itemImage;
      data["item_0" + ix + "_path"] = subData.itemLink;
      data["item_0" + ix + "_title"] = subData.itemTitle;
      data["item_0" + ix + "_desc"] = String(subData.itemDesc).replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";

      console.log("!!!", subData);
    });
</script>
<script>
  var nowArgs = undefined;
  window.orderProcess = function (args) {
    if (!window.is_signed) {
      alertWithRedirect("로그인 후 이용가능합니다.", "/member/login?redirectUrl=" + location.href)
      return;
    }
    nowArgs = args;

    var codes = [];
    for (var item of args.item) {
      if (!item.itemCode) continue;
      codes.push(item.itemCode);
    }

    $("#orderModal ul").html("");
    $("#orderModal").addClass("loading").modal("show");

    axios.post(`/product_available`, { ids: codes }).then(function (r) {
      var o = r.data.RESULT_MSG;
      if (o.fails.length) {
        var itemCodes = o.fails.map(v => v.itemCode);
        var args2 = {
          item: args.item.filter(v => !itemCodes.includes(v.itemCode))
        };
        nowArgs = args2;
        $("#orderModal").modal("hide").removeClass("loading");
        showNotAvailModal(o.fails, function () {
          $("#orderModal ul").html("");
          $("#orderModal").addClass("loading").modal("show");

          if (o.fails.length == codes.length) {
            $("#orderModal").removeClass("loading").modal("hide");
            return;
          }

          get({url: '/order/daily/check/option'}, function (r) {
            if (typeof r.RESULT_MSG == 'object' && r.RESULT_MSG.length > 0) {
              let customerList = r.RESULT_MSG
              if (customerList.length > 5) {
                customerList = customerList.slice(0, 5)
              }

              var latno = 0;
              $.each(customerList, function (i, data) {
                var tpl = $("#orderPosLi").text();
                var nickname = data.nickname;
                if (!nickname) {
                  if (latno == 0) {
                    latno = customerList.filter(v => !!v.nickname).length
                  }
                  nickname = "음용 " + latno;
                  latno++;
                }
                tpl = tpl.replace(/\{nickname\}/g, nickname);
                tpl = tpl.replace(/\{custnumber\}/g, data.custnumber);
                tpl = tpl.replace(/\{prtnId\}/g, data.phiCustomerVo.prtnId);
                $("#orderModal ul").append(tpl);
              })
              $('#orderModal input[name=custnum]:first').click()
              $("#orderModal").removeClass("loading")
            } else {
              location.href = "/order/daily/step1?item=" + encodeURIComponent(JSON.stringify(args2));
            }
          });
        });
      }
      else {
        get({url: '/order/daily/check/option'}, function (r) {
          if (typeof r.RESULT_MSG == 'object' && r.RESULT_MSG.length > 0) {
            let customerList = r.RESULT_MSG
            if (customerList.length > 5) {
              customerList = customerList.slice(0, 5)
            }

            var latno = 0;
            $.each(customerList, function (i, data) {
              var tpl = $("#orderPosLi").text();
              var nickname = data.nickname;
              if (!nickname) {
                if (latno == 0) {
                  latno = customerList.filter(v => !!v.nickname).length
                }
                nickname = "음용 " + latno;
                latno++;
              }
              tpl = tpl.replace(/\{nickname\}/g, nickname);
              tpl = tpl.replace(/\{custnumber\}/g, data.custnumber);
              tpl = tpl.replace(/\{prtnId\}/g, data.phiCustomerVo.prtnId);
              $("#orderModal ul").append(tpl);
            })
            $('#orderModal input[name=custnum]:first').click()
            $("#orderModal").removeClass("loading")
          } else {
            location.href = "/order/daily/step1?item=" + encodeURIComponent(JSON.stringify(args));
          }
        });
      }
    });

  }

  $(document).on("click", "#orderModal button", function (e) {
    var type = $(this).attr("data-type");
    var p = encodeURIComponent(JSON.stringify(nowArgs));;
    if (type === "new") {
      location.href = "/order/daily/step1?item=" + p
    } else if (type === "continue") {
      var c = $("input[name='custnum']:checked");
      var custNumber = c.val();
      var prtnId = c.attr("data-prtn-id");
      location.href = "/mypage/drink/drink/change/" + custNumber + "/" + prtnId + "?item=" + p;
    }
  })
</script>
<textarea id="orderPosLi" style="display: none">
    <li>
        <label class="item-wrapper">
            <input name="custnum" type="radio" value="{custnumber}" data-prtn-id="{prtnId}" />
            <div class="item">
                <div class="contents">
                    <p class="name">
                        {nickname} <span style="margin-left: 0;">{custnumber}</span>
                    </p>
                </div>
            </div>
        </label>
    </li>
</textarea>


<div class="breadcrumb-style">
    <div class="container">
        <ul>
            <li><a>홈</a></li>
            <li><a class="active">맞춤큐레이션</a></li>
        </ul>
    </div>
</div>

<div class="container curation">
    
        <div class="curation-progress-bar">
            <ul>
                <li class="active"><b>01.</b>건강목표</li>
                <li class="active"><b>02.</b>식이섭취</li>
                <li class="active"><b>03.</b>생활습관</li>
            </ul>
        </div>
    
<div class="question-part">
        <div class="title">
            <h3> 당신에게 추천드리는
                 <b>맞춤 상품</b>
             </h3>
        </div>
<div class="card-item">
   <div class="product-wrapper">
         <p>${list[0].program_name }</p>
          <c:forEach var="dto" items="${list}" >
            <div class="product-radio-group">
                <label data-item-index="${dto.program_no }"  data-item-link="product/daily/278"  data-item-image="/resources/assets/images/${dto.system_name }"
                  data-item-title="${dto.products_name }" data-item-desc="2100">
	                <input value="${dto.products_no }" name="itemCode" type="checkbox"/>
	                <div class="check-display"></div>
	                 <div class="thumb" data-product-preview="278"><img src="/resources/assets/images/${dto.system_name }"  alt=""></div>
	                 <p data-product-preview="278">
	                 ${dto.products_name }</p>
               </label>
             </div>
       </c:forEach>
   </div>
</div>

       <div class="button-set sm" style="margin: 20px 0px">
             <button id="cartBtn" class="button-basic black">장바구니</button>
             <button id="orderBtn" class="button-basic primary">주문하기</button>
       </div>
</div>
        

        <div class="result-text">
            ${list[0].program_content }
        </div>
        <div class="alert-area">
                <h4>생활습관 바꾸기</h4>
                <ul>
                    <li data-type="bmi">${list[0].lifestyle_change01 }</li>
                     <li>대표적인 건강 위험 요인인 흡연! 자신과 사랑하는 사람들을 위해 금연을 시작합니다.</li>
                   </ul>
            </div>
            <div class="button-set">
      <button class="button-basic border bottles prefix"
                            onclick="location.href='/customer/product/result/programs.do?singleYn=Y'">
                        <i class="ico"></i>
                        <i class="ico"></i>
                        내게 맞는 프로그램 추천
                    </button>
                
                <button class="button-basic kakao prefix" onclick="javascript:sendKakao()">
                    <i class="ico"></i>
                    카카오톡으로 공유
                </button>
            </div>
        

    </div>
    <div class="modal" id="productPreviewModal" tabindex="-1" style="display: none;" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="width:430px;">
		<div class="modal-content modal-product">


















<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
  </button>
  <div class="thumb-normal">
    
      
        <img src="/file/download//product/20221108/ba5f3929-c8f2-42bf-a7bd-723b54dd684a.jpg">
      
      
      
      
      
    
  </div>
</div>
<div class="modal-body">
  <div class="info-area">
    <h2>슈퍼키즈하이</h2>
    <p>우리 아이 튼튼하게 해주는 하루 채소 섭취</p>
    <div class="product-addiction" style="border-bottom: none">
      <div class="price-item">

        
          
          
            <p>
              2,000<span>원</span></p>
          
        

        <span>(130ml)</span>
      </div>
    </div>
  </div>
  <div class="button-set">
    <a href="/product/daily/430" class="button-basic primary">상세보기</a>
  </div>
</div>

</div>
	</div>
</div>
</div>

<script>
  $(function(){

    axios.get('/user_summary/default').then(function (response) {

      const {info, customerVo} = response.data.RESULT_MSG;

		const ec = ( !info.overEnd) && (info.complex||info.hasHp) && customerVo.phiCustomerVo.intfacId == '0' && customerVo.phiCustomerVo.dlvyCustYn==='Y'
        if(ec&&customerVo){
          $('#quickChangeDrink').attr('href', `/mypage/drink/drink/change/${customerVo.custnumber}/${customerVo.prtnId}`)
          $('#quickChangeSchedule').attr('href', `/mypage/drink/drink/pause/${customerVo.custnumber}/${customerVo.prtnId}`)
        }else {
          $('#quickChangeDrink').attr('href', `/mypage?with=01`)
          $('#quickChangeSchedule').attr('href', `/mypage?with=01`)
        }
        console.log(window.innerWidth)
        if(window.innerWidth>1450){
          $('#mini-side-nav').show();
        }
    }).catch(function (error) {
      if(window.innerWidth>1450) {
        $('#mini-side-nav').show()
      }
	});
    window.addEventListener('resize', function(){
	  if(window.innerWidth>1450){
		$('#mini-side-nav').show();
	  }else {
		$('#mini-side-nav').hide();
	  }
	})

  })
</script>
<div style="display: none" id="mini-side-nav">
	<a href="/mypage/drink/drink"><img src="/resources/images/ui/quick1.png" alt=""></a>
	<a id="quickChangeDrink" href="/mypage/drink/drink"><img src="/resources/images/ui/quick2.png" alt=""></a>
	<a id="quickChangeSchedule" href="/mypage/drink/drink"><img src="/resources/images/ui/quick3.png" alt=""></a>
	<a href="/mypage/drink/bill"><img src="/resources/images/ui/quick4.png" alt=""></a>
	<a href="#"><img src="/resources/images/ui/quickTop.png" alt=""></a>
</div>
</main>
<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>
</body>
</html>