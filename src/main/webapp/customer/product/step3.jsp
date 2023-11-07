<%@ page  language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String path = request.getContextPath(); %>
<html lang="ko">
<head>
<title>풀무원 녹즙 | 맞춤큐레이션</title>
<meta name="description" content="하루 한 병 건강한 습관 풀무원녹즙, 신선한 채소와 과일의 영양을 매일 아침 배송합니다.">
<link rel="shortcut icon" href="/pulmuonePro/resources/assets/images/pul_favicon.png">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/contents2.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/curation.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/a-guide.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/bootstrap.min.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/curation01.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/layout_style.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	
<script type="text/javascript">
</script>

</head>
<body>
<script>
	function getBmi (w,h){
		return (w / ((h * h) / 10000)).toFixed(2);
	}
	const totalCnt = "8"
	let currentPage = 1;
	function handleProgress(){
		const progress = (currentPage) / totalCnt;
		if (progress >= 1) {
			$('.progress-bar').text("100%");
			$("[data-progress-fill]").css("width", "100%");
		} else {
			$('.progress-bar').text((progress * 100) + "%");
			$("[data-progress-fill]").css("width", (progress * 100) + "%");
		}

		return progress;
	}

	function setCurrentPage(page) {
		currentPage = page;
		$("[data-showdesc]").css("display", "none");
		$("[data-showdesc='" + page + "']").css("display", "block");
		handleProgress();
		if (currentPage > totalCnt) {
			$('.last-page-section').show();
			$('.question-section').hide();
		} else {
			$('.last-page-section').hide();
			$('.question-section').show();
			$('.question-section > div.active').removeClass("active");
			$('.question-section > div[data-i=' + (currentPage - 1) + ']').addClass("active");
		}
	}

	$(function (){

		if(!sessionStorage.getItem('req2')||!sessionStorage.getItem('req1')){
//             location.href='/pulmuonePro/customer/product/step1.jsp'
		}
		if(sessionStorage.getItem('req3')){
			const prevReq3 = JSON.parse(sessionStorage.getItem('req3'))
			console.log('req3', prevReq3)
			$('.question-section').children().each((i,v)=>{
				const idx = $(v).attr('id').replaceAll('q-','')
				Object.keys(prevReq3).forEach((value, index)=>{
					console.log($(v).find('.answer-btn-wrapper button').prop('value'))
					if(value === idx){
						if(prevReq3[value] === $(v).find('.answer-btn-wrapper button:first').prop('value'))
						{
							$(v).find('.answer-btn-wrapper button:first').addClass('selected')
							$(v).find('.answer-btn-wrapper button:last').removeClass('selected')
						} else {
							$(v).find('.answer-btn-wrapper button:first').removeClass('selected')
							$(v).find('.answer-btn-wrapper button:last').addClass('selected')
						}
					}
				})

				// const answer = $(v).find('.answer-btn-wrapper').find('.selected').val();
				// return data[idx]=answer
			})
		}

        $('.question-section').children().not(':first-of-type').removeClass('active')

		$('.answer-btn-wrapper button').click(function (){
            if($(this).hasClass('positive-btn')){
                $(this).next('button').removeClass('selected')
            }else {
                $(this).prev('button').removeClass('selected')
            }

			$(this).toggleClass('selected')

            // handleProgress()
		})

		$('.prev-btn').click(function (){
            if (currentPage > 1) {
				setCurrentPage(currentPage - 1);
            } else {
				location.replace("/pulmuonePro/customer/product/step2.jsp");
            }
		})

        $('.next-btn').click(function (){
            const lastSection = $('.last-page-section')
			if (lastSection.css('display') !== 'none') {
				const singleYn = lastSection.find('input[type=radio]:checked').val();
				if (!singleYn) {
					return alert('상품 추천 방식을 선택 해 주세요');
				}

				const req1 = JSON.parse(sessionStorage.getItem('req1'))
				const req2 = JSON.parse(sessionStorage.getItem('req2'))
				const req3 = JSON.parse(sessionStorage.getItem('req3'))

				const data = {...req1, ...req2, ...req3}
				const body = Object.entries(data).filter(v => !!parseInt(v[0])).map(
						v => ({idx: v[0], answer: v[1]}));
				newPost({
					url: '/pulmuonePro/customer/product/result/',
					data: {singleYn, answerList: body}
				}, function (data) {
					var bmi = data.RESULT_MSG.bmi || 0;
					if (bmi == 0 && req1.weight && req1.tallness) {
						bmi = getBmi(req1.weight, req1.tallness)
					}
					location.href = '/customer/product/result/' + data.RESULT_MSG.execution.idx
							+ '?singleYn=' + singleYn + '&bmi=' + bmi + '&questions='
							+ data.RESULT_MSG.questions.join(',');
				});
			}
            if (currentPage <= totalCnt) {
				const data = {}
				$('.question-section').children().each((i, v) => {
					const idx = parseInt($(v).attr('id').replaceAll('q-', ''));
					const answer = $(v).find('.answer-btn-wrapper').find('.selected').val();
					return data[idx] = answer
				})

				const habbit = Object.values(data)
				if (!habbit[currentPage - 1]) {
					alert('예, 아니오 중 선택해 주세요.')
					return;
				}
				sessionStorage.setItem('req3', JSON.stringify(data));
				setCurrentPage(currentPage + 1);
            }
        })
	})
</script>

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
			<h3>자신에게 해당하는 생활습관을 선택하세요.</h3>
			<div class="sm-progress-bar">
				<label class="progress-bar">12.5%</label>
				<span class="fill" data-progress-fill style=" width:12.5%"></span>
			</div>
		</div>
		<div class="question-section">
			
				<div class="active" data-i="0" id="q-7">
					<div class="card-item">
						<span class="mark">Q.</span>
						<h4>아침 식사를 거른다</h4>
						<div class="answer-btn-wrapper">
							<button value="0" class="positive-btn button-basic border" type="button">
								예
							</button>
							<button value="1" class="negative-btn button-basic border" type="button">
								아니오
							</button>
						</div>
					</div>
				</div>
			
				<div class="active" data-i="1" id="q-8">
					<div class="card-item">
						<span class="mark">Q.</span>
						<h4>식사 시간이 불규칙하다</h4>
						<div class="answer-btn-wrapper">
							<button value="0" class="positive-btn button-basic border" type="button">
								예
							</button>
							<button value="1" class="negative-btn button-basic border" type="button">
								아니오
							</button>
						</div>
					</div>
				</div>
			
				<div class="active" data-i="2" id="q-9">
					<div class="card-item">
						<span class="mark">Q.</span>
						<h4>야식하는 습관이 있다</h4>
						<div class="answer-btn-wrapper">
							<button value="0" class="positive-btn button-basic border" type="button">
								예
							</button>
							<button value="1" class="negative-btn button-basic border" type="button">
								아니오
							</button>
						</div>
					</div>
				</div>
			
				<div class="active" data-i="3" id="q-10">
					<div class="card-item">
						<span class="mark">Q.</span>
						<h4>배가 불러도 더 먹는다</h4>
						<div class="answer-btn-wrapper">
							<button value="0" class="positive-btn button-basic border" type="button">
								예
							</button>
							<button value="1" class="negative-btn button-basic border" type="button">
								아니오
							</button>
						</div>
					</div>
				</div>
			
				<div class="active" data-i="4" id="q-11">
					<div class="card-item">
						<span class="mark">Q.</span>
						<h4>일주일에 2회 이상은 과음한다</h4>
						<div class="answer-btn-wrapper">
							<button value="0" class="positive-btn button-basic border" type="button">
								예
							</button>
							<button value="1" class="negative-btn button-basic border" type="button">
								아니오
							</button>
						</div>
					</div>
				</div>
			
				<div class="active" data-i="5" id="q-12">
					<div class="card-item">
						<span class="mark">Q.</span>
						<h4>식사할 때 반주하는 습관이 있다</h4>
						<div class="answer-btn-wrapper">
							<button value="0" class="positive-btn button-basic border" type="button">
								예
							</button>
							<button value="1" class="negative-btn button-basic border" type="button">
								아니오
							</button>
						</div>
					</div>
				</div>
			
				<div class="active" data-i="6" id="q-13">
					<div class="card-item">
						<span class="mark">Q.</span>
						<h4>흡연을 한다</h4>
						<div class="answer-btn-wrapper">
							<button value="0" class="positive-btn button-basic border" type="button">
								예
							</button>
							<button value="1" class="negative-btn button-basic border" type="button">
								아니오
							</button>
						</div>
					</div>
				</div>
			
				<div class="active" data-i="7" id="q-14">
					<div class="card-item">
						<span class="mark">Q.</span>
						<h4>운동을 안하거나, 권고 지침 수준보다는 적게 운동 한다</h4>
						<div class="answer-btn-wrapper">
							<button value="0" class="positive-btn button-basic border" type="button">
								예
							</button>
							<button value="1" class="negative-btn button-basic border" type="button">
								아니오
							</button>
						</div>
					</div>
				</div>
			
		</div>
	</div>
	<div style="display: none" class="last-page-section question-part">
		<div class="title">
			<h3>
				모든 설문을 작성하셨습니다.<br/>
				결과를 확인하세요.
			</h3>
		</div>
		<div class="card-item">
			<p>희망하는 추천 방식을 선택해주세요</p>
			<div class="result-select-group">
				<label class="package" for="package">
					<input checked name="singleYn" id="package" type="radio" value="N">
					<div>
						<div class="check"></div>
						<span><b>내게 맞는 프로그램</b>을<br/>추천 받습니다.</span>
					</div>
				</label>
				<label class="single" for="single">
					<input name="singleYn" id="single" type="radio" value="Y">
					<div>
						<div class="check"></div>
						<span><b>내게 맞는 상품</b>을<br/>추천 받습니다.</span>
					</div>
				</label>
			</div>
		</div>

	</div>
	<div data-showdesc="5" class="alert-area" style="display: none;">
		<h4>과음의 기준</h4>
		<ul>
			<li>
				맥주로는 남자 5캔, 여자 3캔 이상 섭취
			</li>
		</ul>
	</div>
	<div data-showdesc="8" class="alert-area" style="display: none;">
		<h4>한국인 신체활동 지침</h4>
		<ul>
			<li>
				중강도 운동 시 일주일에 총 2시간 30분 이상 실시(빨리 걷기, 자전거 타기 등)
			</li>
			<li>
				고강도 운동 시 일주일에 총 1시간 15분 이상 실시 (등산, 조깅, 줄넘기, 수영 시합 등).
			</li>
		</ul>
	</div>
	<div class="button-set w220">
		<button class="prev-btn button-basic border" type="button" id="prevPage">이전으로</button>
<!-- 		<a href="javascript:history.back()" type="button" class="button-basic border">이전으로</a> -->
		<button class="next-btn button-basic primary" type="button" id="nextPage">다음으로</button>
	</div>
</div>

</div>
<style>
	.question-section > div {
		display: none;
	}
    .question-section > div.active {
        display: block;
    }
</style>

<script>

	if($("input[id=package]").is("checked")){
	$("#nextPage").click(function() {
	location.href="/pulmuonePro/customer/product/result/programs.jsp"
	} else {
		location.href="/pulmuonePro/customer/product/result/products.jsp"
	}
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
</body>
</html>