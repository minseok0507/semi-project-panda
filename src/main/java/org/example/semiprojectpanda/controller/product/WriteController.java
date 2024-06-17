package org.example.semiprojectpanda.controller.product;

import lombok.RequiredArgsConstructor;
import org.example.semiprojectpanda.dto.CategoryDto;
import org.example.semiprojectpanda.service.ProductWriteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class WriteController {

    private final ProductWriteService productWriteService;

    /*
    private String bucketName = "";
    private String folderName = "";

    @Autowired
    private NcpObjectStorageService storageService;
    */

    @GetMapping("/product/write")
    public String productWrite(Model model) {

        //CATEGORY 받아와서 나열하기
        List<CategoryDto> categories = productWriteService.getAllCategories();
        model.addAttribute("categories", categories);




        return "product/product-write";
    }
}
