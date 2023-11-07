<%@ page trimDirectiveWhitespaces="true" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String path = request.getContextPath(); %>
<% String url = request.getServerName().toString();
request.setAttribute("url", url);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>풀무원 녹즙 | 맞춤큐레이션</title>
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/contents2.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/curation.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/a-guide.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/bootstrap.min.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/bootstrap-fdd.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/curation01.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/layout_style.css">
<link rel="shortcut icon" href="/pulmuonePro/resources/assets/images/pul_favicon.png">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">

/* body */

*, html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
    margin: 0;
    padding: 0;
    border: 0;
    vertical-align: baseline;
    font-style: normal;
}

a:not([href]):not([class]) {
    color: inherit;
    text-decoration: none;
}
</style>
</head>
<body class="modal-open" style="padding-right: 17px;">

<div id="container-wrapper" class="container-wrapper"> <!-- TODO : 회원쪽 페이지들은 <div class="container-wrapper member"> -->

<div class="breadcrumb-style">
    <div class="container">
		<div class="container">
			<ul>
				<li><a>홈</a></li>
				<li><a class="active">맞춤큐레이션</a></li>
			</ul>
		</div>
    </div>
</div>
<form class="curation">
    <div class="container curation">
        <div class="curation-progress-bar">
            <ul>
                <li class="active"><b>01.</b>건강목표</li>
                <li><b>02.</b>식이섭취</li>
                <li><b>03.</b>생활습관</li>
            </ul>
        </div>
        <div class="question-part">
            <div class="title">
                <h3>평소 관심있는 건강 목표를 선택하세요.</h3>
                <span>다수 항목 선택 가능</span>
            </div>
            <div class="filled-radio-group" id="health" value="all">

                <label class="item">
                      <input type="checkbox" name="tired" value="0" class="checkGoal">
                      <p>활력/피로</p>
                </label>
                
                
			    <label class="item">
                     <input type="checkbox" name="eye" value="0" class="checkGoal">
                     <p>눈 건강</p>
                 </label>
                
                <label class="item">
                     <input type="checkbox" name="sleep" value="0" class="checkGoal">
                     <p>수면</p>
                </label>
                
                    
                <label class="item">
                    <input type="checkbox" name="lung" value="0" class="checkGoal">
                    <p>장 건강</p>
                </label>
                
               <label class="item">
                   <input type="checkbox" name="stomach" value="0" class="checkGoal">
                    <p>위 건강</p>
               </label>
                
                <label class="item">
                   <input type="checkbox" name="weight" value="0" class="checkGoal">
                   <p>체중 관리</p>
                 </label>
                

            </div>
        </div>
        <div class="question-part">
            <div class="title">
                <h3>키와 몸무게를 입력해 주세요.</h3>
            </div>
            <div class="curation-input-row">
                <div class="form-input" style="">
                    <dl>
                        <dt><label>키</label></dt>
                        <dd>
                            <input name="tallness" type="number"
                                   style="width:50%; text-align: right" step="0.1"
                                   placeholder="예) 172.5 " onkeydown="javascript: return event.keyCode == 69 ? false : true" onblur="this.value=this.value.replace(/[^\d.-]/g,'')"/>
                            <span>cm</span>
                        </dd>
                    </dl>
                </div>
                <div class="form-input" style="">
                    <dl>
                        <dt><label>몸무게</label></dt>
                        <dd>
                            <input name="weight" type="number" style="width:50%; text-align: right"
                                   step="0.1" placeholder="예) 65.9 " onkeydown="javascript: return event.keyCode == 69 ? false : true" onblur="this.value=this.value.replace(/[^\d.-]/g,'')"/>
                            <span>kg</span>
                        </dd>
                    </dl>
                </div>
            </div>
            <span style="margin-top:12px; display: block; text-align: center;" class="description">키와 몸무게 정보는 큐레이션에만 활용되며 별도 저장되지 않습니다.</span>
        </div>
        <div class="button-set">
             <button class="submit button-basic primary wide" id="nextPage">다음으로</button>
       </div>

<div class="modal fade show" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" style="display: block; display:none; padding-right: 17px;" aria-modal="true" role="dialog">
	<div class="modal-dialog modal-dialog-centered">
		<div id="modal" class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="alertModalLabel"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				</button>
			</div>
			<div class="modal-body">1개 이상의 목표를 선택해 주세요</div>
			<button type="button" class="modal-footer" data-dismiss="modal">확인</button>
		</div>
	</div>
</div>

    </div>
</form>

<script>


// 체크박스 선택 없으면 모달창
$("#nextPage").on("click", function() {
	if($("input:checkbox:checked").is(":checked") == true){
		var data = $(this).val();
		if (data.length > 0) {
			$(this).attr("checked", true);
		}
		$("#alertModal").hide();
		location.href= "<%=path%>/customer/product/step2.jsp"
	}else{
		$("#alertModal").show();
		return;
	}	
})

// 모달창 닫기
$(".modal-footer").click(function() {
	$("#alertModal").fadeOut();
	return;
})


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
	<a href="/mypage/drink/drink"><img src="/pulmuonePro/customer/curation_image/quick1.png" alt=""></a>
	<a id="quickChangeDrink" href="/mypage/drink/drink"><img src="/pulmuonePro/customer/curation_image/quick2.png" alt=""></a>
	<a id="quickChangeSchedule" href="/mypage/drink/drink"><img src="/pulmuonePro/customer/curation_image/quick3.png" alt=""></a>
	<a href="/mypage/drink/bill"><img src="/pulmuonePro/customer/curation_image/quick4.png" alt=""></a>
	<a href="#"><img src="/pulmuonePro/customer/curation_image/quickTop.png" alt=""></a>
</div>
</div>

<%-- <form method="post" action="<%= path%>/customer/product/step1.jsp"></form> --%>

<script type="text/javascript">

// BMI 계산
  function getBmi(w, h) {
    return (w / ((h * h) / 10000)).toFixed(2);
  }

  let historyItem = {}
  $(function () {
      if(sessionStorage.getItem('req1')){
          const prevReq1 = JSON.parse(sessionStorage.getItem('req1'))
          console.log('req1', prevReq1)
          const prevReqKey = Object.keys(prevReq1)
          $('input[name=tallness]').val(prevReq1.tallness)
          $('input[name=weight]').val(prevReq1.weight)
          $('.filled-radio-group').children().each((i,v)=>{
              console.log(prevReqKey)
              prevReqKey.forEach((value, index) => {
                  if(value===$(v).children().prop('name')){
                      $(v).children().prop('checked',true)
                  }
              })
              console.log($(v).children().prop('name'))
          })

      }

    $(document).on('keyup', "input[name=tallness],[name=weight]", function () { // 키 소수점 1자리까지 입력 제한
      var value = $(this).val();

      var nExp = /[^0-9\.]/g;
      if (nExp.test(value)) {
        console.log("set value", value, value.replace(/[^0-9\.]/g, ""))
        $(this).val(value.replace(nExp, ""));
      }
      var regExp = /^\d{0,10}(\.\d{0,1})?$/;
      if (!regExp.test(this.value)) {
        $(this).val(value.substring(0, value.length - 1));
      }
    });

    $('.bmi-chk').change(function () {
      if ($(this).prop('checked')) {
        $(".bmi-wrapper").addClass('active')
      } else {
        $(".bmi-wrapper").children().each((i, v) => $(v).val(undefined))
        $(".bmi-wrapper").removeClass('active')
      }
    })

    $('form.curation').submit(function (e) {
      e.preventDefault();
      const requestBody = $(this).serializeObject();
      const goal = Object.keys(requestBody).find(e => e > 0) // 건강목표 유효성 체크
      if (!goal) {
        alert('1개 이상의 목표를 선택해 주세요')
        return;
      }
      // 체중 키 입력 필수 아니라고 함
      if (requestBody[6]) {
        if (!requestBody.tallness) {
          alert('체중 및 키를 입력해 주세요');
        } else if (!requestBody.weight) {
          alert('체중 및 키를 입력해 주세요');
        } else {
          requestBody[6] = getBmi(requestBody.weight, requestBody.tallness);
        }
      }
      sessionStorage.setItem('req1', JSON.stringify(requestBody));
      location.href = '<%=path%>/customer/product/step2';
    })
  })
</script>
</body>
</html>