class SliderModel{
  String imagePath;
  String title;
  String desc;

  SliderModel({this.imagePath,this.title,this.desc});

  void setImageAssetPath(String getImagePath){
    imagePath = getImagePath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imagePath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}

List<SliderModel> getSlides(){

  List <SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setImageAssetPath("assets/images_onboarding/explore_icon_purple.png");
  sliderModel.setTitle("Explore");
  sliderModel.setDesc("""Discover all that 
  CUHK Shenzhen 
  has to offer""".trim());
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setImageAssetPath("assets/images_onboarding/major_purple.png");
  sliderModel.setTitle("Choose a Major");
  sliderModel.setDesc("""Dive in all our majors,
  check their courses,
  and apply""".trim());
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setImageAssetPath("assets/images_onboarding/chat_purple.png");
  sliderModel.setTitle("Message Us");
  sliderModel.setDesc("""Talk directly with us
or our selected
international students""".trim());
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //4
  sliderModel.setImageAssetPath("assets/images_onboarding/apply_icon.png");
  sliderModel.setTitle("Apply");
  sliderModel.setDesc("""Once you are ready, 
apply directly
without any hassle""".trim());
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}