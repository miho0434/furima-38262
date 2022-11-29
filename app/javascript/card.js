const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();  //通常のRuby on Railsにおけるフォーム送信処理のキャンセル記述
    
    //フォーム情報の取得
    // id"charge-form"フォームの情報を取得し、それをFormDataオブジェクト(フォームに入力された値を取得できるオブジェクト)として生成
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {                 //変数cardに代入するオブジェクトとして定義)
      number: formData.get("purchase_form[number]"),  //各フォームのname属性の値
      exp_month: formData.get("purchase_form[exp_month]"),
      exp_year: `20${formData.get("purchase_form[exp_year]")}`,
      cvc: formData.get("purchase_form[cvc]"),
    };

    //カードの情報をトークン化
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;  //type属性の値にhiddenを指定
        renderDom.insertAdjacentHTML("beforeend", tokenObj); //フォームの中に作成したinput要素を追加
      }

      //カードの情報を削除する記述
      document.getElementById("card-number").removeAttribute("name"); 
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit(); //サーバーサイドにフォームを相違
    });
  });
};

window.addEventListener("load", pay);