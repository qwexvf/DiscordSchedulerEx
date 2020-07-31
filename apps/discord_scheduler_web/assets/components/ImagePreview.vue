<template>
  <b-form-group label="画像">
    <img v-if="imageSrc" width="600" height="300" :src="imageSrc" />
    <b-form-file
      v-model="file"
      :state="Boolean(file)"
      placeholder="画像を選択もしくはドラッグアンドドロップ"
      drop-placeholder="Drop file here..."
      @change="onFileChange"
    />

    <b-button v-if="imageSrc" @click="reset()">削除</b-button>
  </b-form-group>
</template>

<script lang="ts">
import {
  Component,
  Prop,
  Vue,
} from "nuxt-property-decorator";

@Component
export default class ImagePreview extends Vue {
  private imageSrc: string | ArrayBuffer | null = null;
  private file = null;

  @Prop()
  private image!: string;

  async mounted() {
    if (this.image) {
      this.imageSrc = this.image;
    }
  }

  onFileChange(input: any) {
    if (input.target.files && input.target.files[0]) {
      const reader = new FileReader();
      const _this = this;

      reader.onload = (e: any) => {
        _this.imageSrc = e.target.result;
        _this.$emit("updateImageSrc", _this.imageSrc);
      };

      this.file = input.target.files[0];
      reader.readAsDataURL(input.target.files[0]);

      this.$emit("update:image", this.file);
    }
  }

  reset() {
    this.imageSrc = null;
    this.file = null;
  }
}
</script>
