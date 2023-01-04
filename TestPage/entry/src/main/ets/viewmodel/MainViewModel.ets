import Itemdata from '../common/bean/Itemdata';


export class MainViewModel {

  getSwiperImage(): Array<Resource> {
    let swiperImages: Resource[] = [
      $r('app.media.fig1'),
      $r('app.media.fig2'),
      $r('app.media.fig3'),
      $r('app.media.fig4'),
    ];
    return swiperImages;
  }

  getFirstGridData(): Array<Itemdata> {
    let firstGridData: Itemdata[] = [
      new Itemdata($r('app.string.my_love'),$r('app.media.love')),
      new Itemdata($r('app.string.history_record'),$r('app.media.record')),
      new Itemdata($r('app.string.message'),$r('app.media.message')),
      new Itemdata($r('app.string.shopping_cart'),$r('app.media.shopping')),
      new Itemdata($r('app.string.my_goal'),$r('app.media.target')),
      new Itemdata($r('app.string.group'),$r('app.media.circle')),
      new Itemdata($r('app.string.favorites'),$r('app.media.favorite')),
      new Itemdata($r('app.string.recycle_bin'),$r('app.media.recycle'))
    ];
    return firstGridData;
  }

  getSecondGridData(): Array<Itemdata> {
    let secondGridData: Itemdata[] = [
      new Itemdata($r('app.string.mainPage_top'),$r('app.media.top'), $r('app.string.mainPage_text_top')),
      new Itemdata($r('app.string.mainPage_new'),$r('app.media.new'), $r('app.string.mainPage_text_new')),
      new Itemdata($r('app.string.mainPage_brand'),$r('app.media.brand'), $r('app.string.mainPage_text_brand')),
      new Itemdata($r('app.string.mainPage_found'),$r('app.media.found'), $r('app.string.mainPage_text_found'))
    ];
    return secondGridData;
  }

  getSettingListData(): Array<Itemdata> {
    let settingListData: Itemdata[] = [
      new Itemdata($r('app.string.setting_list_news'),$r('app.media.news'), $r('app.string.setting_toggle')),
      new Itemdata($r('app.string.setting_list_data'),$r('app.media.data'), null),
      new Itemdata($r('app.string.setting_list_menu'),$r('app.media.menu'), null),
      new Itemdata($r('app.string.setting_list_about'),$r('app.media.about'), null),
      new Itemdata($r('app.string.setting_list_storage'),$r('app.media.storage'), null),
      new Itemdata($r('app.string.setting_list_privacy'),$r('app.media.privacy'), null)
    ];
    return settingListData;
  }
}

export default new MainViewModel();