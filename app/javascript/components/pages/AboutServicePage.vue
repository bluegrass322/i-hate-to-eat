<template>
  <div id="privacy-policy-page" class="py-15 px-10 text-body-2">
    <div id="text-group" class="accent--text">
      <div class="title-group mb-10">
        <div class="d-flex align-end text-subtitle-1 font-weight-bold mb-4">
          <div class="under-line line-left" />
          サービス概要（調整中）
        </div>
        <div class="text-body-2">
          <div>
            <p>本サービスは、</p>
            <div>
              「食事が嫌い」<br />
              「何を食べるか考えることすら面倒」<br />
              「そもそも食事を取ることを忘れてしまう」<br />
              「けれど栄養は摂らなければ生きていけない」……
            </div>
            <div class="mt-5">
              そんな悩みを持つ方々のために、
              <div class="my-4">
                <ruby class="text-h6 info--text font-weight-bold">
                  "Eat this for now !"<rt>とりあえずこれ食っとけ</rt> </ruby
                ><br />
              </div>
              を提案します。
            </div>
          </div>
        </div>
      </div>

      <div class="section01 mb-15">
        <div class="section-title text-subtitle-2 font-weight-bold mb-6">
          <div class="pl-1">Step1. おすすめ食材から提案を作成</div>
          <div class="under-line-long" />
        </div>
        <div class="section-text">
          <p class="indented">
            文部科学省のとりまとめた、<span
              class="text-subtitle-1 info--text font-weight-bold"
              >『日本食品標準成分表2020年版』</span
            >を参考に、 栄養価の高いおすすめの食材を選出。
          </p>
          <p class="indented">
            毎日自動で、<span
              class="text-subtitle-1 info--text font-weight-bold"
              >「とりあえずこの4つだけでも食べておきませんか？」</span
            >という 提案を作成します。
          </p>
        </div>
      </div>

      <div class="section02 mb-15">
        <div class="section-title text-subtitle-2 font-weight-bold mb-6">
          <div class="pl-1">Step2. 栄養摂取基準の確認</div>
          <div class="under-line-long" />
        </div>
        <div class="section-text">
          <p class="indented">
            マイページから登録した性別・年齢・身長・体重から、
            生命維持のために1日に最低限必要なエネルギー量である
            <span class="text-subtitle-1 info--text font-weight-bold"
              >基礎代謝量（BMR）</span
            >を計算。
          </p>
          <p class="indented">
            さらに、厚生労働省の制定した<span
              class="text-subtitle-1 info--text font-weight-bold"
              >『日本人の食事摂取基準（2020年版）』</span
            >を参考に、
            性別・年代ごとにミクロ栄養素（ビタミン・ミネラル）の摂取目標量/日を設定します。
          </p>
        </div>
      </div>

      <div class="section03 mb-15">
        <div class="section-title text-subtitle-2 font-weight-bold mb-6">
          <div class="pl-1">Step3. 食事記録の作成</div>
          <div class="under-line-long" />
        </div>
        <div class="section-text">
          <p class="indented">
            提案された食材に対し「食べる」を選択した場合は、食材名と摂取できた栄養の合計量の記録を作成。
          </p>
          <p class="indented">
            また、設定した栄養摂取基準とてらしあわせて
            <span class="text-subtitle-1 info--text font-weight-bold"
              >目標に対する摂取達成度</span
            >が確認でき、 自身の食生活を客観視するためのきっかけにもなります。
          </p>
        </div>
      </div>

      <div class="section04 mb-15">
        <div class="section-title text-subtitle-2 font-weight-bold mb-6">
          <div class="pl-1">Step.4 LINEにリマインド</div>
          <div class="under-line-long" />
        </div>
        <div class="section-text">
          <p class="indented">
            <span class="text-subtitle-1 info--text font-weight-bold"
              >「そもそも食事をとることを忘れてしまう」</span
            >
            という方のために、アカウント連携を行うことで
            <span class="text-subtitle-1 info--text font-weight-bold"
              >各々が設定した時間に提案の内容をLINEで通知する機能</span
            >も。
          </p>
          <p class="indented">
            LINE通知を使用するかどうか、また通知を何時に行うかは
            <span class="text-subtitle-1 info--text font-weight-bold"
              >マイページのアカウント設定ページ</span
            >
            から設定することができます。
          </p>
        </div>
      </div>

      <div class="section05 mb-15">
        <div class="section-title text-subtitle-2 font-weight-bold mb-6">
          <div class="pl-1">おまけ機能： 健康貯金</div>
          <div class="under-line-long" />
        </div>
        <div class="section-text">
          <p class="indented">とはいえやはり食事をとるのは面倒くさいもの。</p>
          <p class="indented">
            そこでほんの少しでもモチベーションの足しになって欲しいと、摂取したエネルギー（=
            kcal）の合計量を
            <span class="text-subtitle-1 info--text font-weight-bold"
              >健康貯金</span
            >としてカウント。
          </p>
          <div>
            <div class="text-subtitle-1 info--text font-weight-bold">
              きちんと食事ができた<br />
              → 病気のリスクが少し下がる<br />
              → 将来的に治療にかかる費用が少し減る
            </div>
          </div>
          <p class="indented mt-5">
            食べることはあなたの大事なお金を節約すること
            ……そう考えてみませんか？
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
/* id */
#privacy-policy-page {
  margin: 0 auto;
  max-width: 1030px;
  height: 100%;
  width: 100%;
}

#text-group {
  height: 100%;
  width: 100%;
}

/* class */
.jus-end {
  justify-self: end;
}

.under-line {
  border-bottom: 1px solid rgb(245, 245, 246);
  position: relative;
  top: -7px;
}

.under-line.line-left {
  margin-right: 5px;
  width: 13px;
}

.under-line-long {
  border-bottom: 1px solid rgb(245, 245, 246);
  width: 100%;
}

/* htmlタグ */
a,
li,
p {
  overflow-wrap: break-word;
}

.v-application a {
  color: rgb(245, 245, 246);
}

li {
  list-style-type: decimal;
  padding-bottom: 10px;
}

.indented {
  text-indent: 1em;
}
</style>
