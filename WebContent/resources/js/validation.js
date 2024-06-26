function CheckAddProduct() {

    // addProduct에 설정한 id값을 통하여 getElementById를 이용해 가져옴.
    var productId = document.getElementById("productId");
    var name = document.getElementById("name");
    var unitPrice = document.getElementById("unitPrice");
    var unitsInStock = document.getElementById("unitsInStock");
    
    //상품 아이디 체크 부분
    if(!check(/^P[0-9]{4,11}$/, productId, "[상품 코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요.\n"
    		+ "첫 글자는 반드시 대문자P로 시작해주세요.")){
        return false;
    }
    //상품명 체크
    if(name.value.length < 3 || 12 < name.value.length) {
        alert("[상품명]\n최소 3자~최대 12자까지 입력해 주세요.");
        name.select();
        name.focus();
        return false;
    }
    //상품 가격을 체크
    if(unitPrice.value.length == 0 || isNaN(unitPrice.value)) {
        alert("[가격]\n숫자만 입력해 주세요.");
        unitPrice.select();
        unitPrice.focus();
        return false;
    }
    if(unitPrice.value < 0) {
        alert("[가격]\n음수를 입력할 수 없습니다.");
        unitPrice.select();
        unitPrice.focus();
        return false;
    }
    //재고 수량 체크하는 부분
    if(isNaN(unitsInStock.value)) {
        alert("[재고 수]\n숫자만 입력해 주세요.");
        unitsInStock.select();
        unitsInStock.focus();
        return false;
    }
    if(unitsInStock.value < 0) {
        alert("[재고 수]\n음수를 입력할 수 없습니다.");
        unitsInStock.select();
        unitsInStock.focus();
        return false;
    }

    document.newProduct.submit();

   //check함수는 정규표현식(regExp), 유효성 검사를 하는 부분(e), 오류가 발생하면 알려줄 메시지(msg)
   //3개 매개변수를 활용하여 패턴이 맞는지를 검증하는 내부 함수이다.
    function check(regExp, e, msg){
    	//정규 표현식에 적합하다면...
        if(regExp.test(e.value)){
            return true;
        }
        alert(msg);
        e.select();
        e.focus();
        return false;
    }
}