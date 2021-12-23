export const DESC_COMMON = '食事嫌いのための、食材提案 & リマインドツール。';

export const DESC_DEFAULT = [
  '「食事が嫌い」「何を食べるか考えることすら面倒」「そもそも食事を取ることを忘れてしまう」……',
  'そんな悩みを持つ方々のために、特に栄養価の高い食材を1日に4つサジェスト。',
  'さらにLINEアカウントを連携すれば、設定した時間にリマインド通知を受け取ることが可能です。',
].join('');

// 各ページごとのdescription
// パブリック
const login =
  'ユーザー登録がお済みの方は、こちらのページからログインすることができます。';

const register = [
  'こちらのページから新規会員登録が可能です。',
  'なお、登録の際は先に利用規約及びプライバシーポリシーをお読みいただき、',
  '同意なされたうえでご登録くださいますようお願いいたします。',
].join('');

// 要ログイン
const home = [
  '食事をとると、こちらのページで栄養素ごとの合計摂取量と、',
  '摂取目標量に対する達成度をグラフで確認することができます。',
].join('');

const mypageAccount = [
  'こちらのページではユーザー名、メールアドレス、',
  'LINE通知機能のON・OFFおよび通知の時間を設定することができます。',
].join('');

const mypageSetting = [
  'こちらのページでは性別・生年月日・身長・体重を設定することができ、',
  'また、そこから算出された基礎代謝量および栄養摂取基準を確認することができます。',
].join('');

const mypageWithdrawal = 'こちらのページから退会申請が行えます。';

const suggestion =
  'こちらのページではその日提案された食材の詳細情報と、4種類の合計の栄養価を確認することができます。';

export default Object.freeze({
  // パブリック
  REGISTER: register,
  LOGIN: login,

  // 要ログイン
  HOME: home,
  MYPAGE_SETTING: mypageSetting,
  MYPAGE_ACCOUNT: mypageAccount,
  MYPAGE_WITHDRAWAL: mypageWithdrawal,
  SUGGESTION: suggestion,
});
